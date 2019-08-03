$(function() {
  $('.post-cards').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    path : 'nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    append : '.post-card',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    prefill: true,  // 一番下まで読まれる前にpathを読み込む
    button: '.loadmore-btn',
    scrollThreshold: false,
    hideNav: '.pagination'
  })
})