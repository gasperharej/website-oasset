(function () {
  function px(n) { return `${n.toFixed(1)}px`; }

  function q(root, sel) { return root ? root.querySelector(sel) : null; }

  function updateEllipses() {
    const wrap = document.querySelector(".featuresEllipseWrap");
    if (!wrap) return false;

    const comm = document.getElementById("communication");
    const asset = document.getElementById("asset-management");
    if (!comm || !asset) return false;

    // Prefer placeholders
    const commA = q(comm, ".placeA") || q(comm, ".phoneA");
    const commB = q(comm, ".placeB") || q(comm, ".phoneB");
    const assetA = q(asset, ".placeA") || q(asset, ".phoneA");
    if (!commA || !commB || !assetA) return false;

    const w = wrap.getBoundingClientRect();
    const rCommA = commA.getBoundingClientRect();
    const rCommB = commB.getBoundingClientRect();
    const rAssetA = assetA.getBoundingClientRect();

    // If layout not settled (0 sizes), skip and retry later
    if (w.width === 0 || w.height === 0) return false;
    if (rCommA.width === 0 || rCommA.height === 0) return false;
    if (rCommB.width === 0 || rCommB.height === 0) return false;
    if (rAssetA.width === 0 || rAssetA.height === 0) return false;

    // LEFT ellipse:
    // centerX = vertical center of communication.placeA
    // centerY = bottom of communication.placeB
    const ellLcx = (rCommA.left + rCommA.right) / 2 - w.left;
    const ellLcy = rCommB.bottom - w.top;

    // RIGHT ellipse:
    // centerX = right edge (handled in CSS with left:100%)
    // centerY = bottom of asset-management.placeA
    const ellRcy = rAssetA.bottom - w.top;

    if (!Number.isFinite(ellLcx) || !Number.isFinite(ellLcy) || !Number.isFinite(ellRcy)) return false;

    wrap.style.setProperty("--ellL-cx", px(ellLcx));
    wrap.style.setProperty("--ellL-cy", px(ellLcy));
    wrap.style.setProperty("--ellR-cy", px(ellRcy));

    wrap.classList.add("isEllipsesReady");
    return true;
  }

  let raf = 0;
  let tries = 0;

  function scheduleRetryBurst() {
    tries = 0;

    const tick = () => {
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(() => {
        // Two frames helps avoid “measured mid-layout”
        requestAnimationFrame(() => {
          const ok = updateEllipses();
          if (!ok && tries < 40) {
            tries++;
            setTimeout(tick, 50); // retry for ~2 seconds max
          }
        });
      });
    };

    tick();
  }

  function scheduleOnce() {
    cancelAnimationFrame(raf);
    raf = requestAnimationFrame(() => updateEllipses());
  }

  // 1) ASAP after DOM is ready
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", scheduleRetryBurst, { once: true });
  } else {
    scheduleRetryBurst();
  }

  // 2) Again after window load (images etc.)
  window.addEventListener("load", scheduleRetryBurst, { passive: true });

  // 3) Fonts can shift line heights
  if (document.fonts && document.fonts.ready) {
    document.fonts.ready.then(scheduleRetryBurst).catch(() => {});
  }

  // 4) Responsive changes
  window.addEventListener("resize", scheduleOnce, { passive: true });

  // 5) Observe actual layout changes
  const wrap = document.querySelector(".featuresEllipseWrap");
  if (wrap) {
    const ro = new ResizeObserver(() => scheduleOnce());
    ro.observe(wrap);

    // Observe placeholders too (more precise than observing the whole document)
    const comm = document.getElementById("communication");
    const asset = document.getElementById("asset-management");
    const commA = comm && (q(comm, ".placeA") || q(comm, ".phoneA"));
    const commB = comm && (q(comm, ".placeB") || q(comm, ".phoneB"));
    const assetA = asset && (q(asset, ".placeA") || q(asset, ".phoneA"));
    if (commA) ro.observe(commA);
    if (commB) ro.observe(commB);
    if (assetA) ro.observe(assetA);

    // If hydration swaps nodes, re-run burst when DOM under wrap changes
    const mo = new MutationObserver(() => scheduleRetryBurst());
    mo.observe(wrap, { childList: true, subtree: true });
  }
})();