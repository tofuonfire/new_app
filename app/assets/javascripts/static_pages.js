$(function() {
  $('.following-posts-container').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    append : '.following-posts-container .post-frame',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    button: '.following-posts-footer .loadmore-btn',
    scrollThreshold: false,
    path : '.following-posts-footer nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    hideNav: '.pagination'
  })
})

$(function() {
  $('.latest-post-cards').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    append : '.latest-post-cards .post-card',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    button: '.latest-posts-footer .loadmore-btn',
    scrollThreshold: false,
    path : '.latest-posts-footer nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    hideNav: '.latest-posts-footer .pagination'
  })
})