$(function() {
  $('.post-cards').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    path : 'nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    append : '.post-card',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    button: '.loadmore-btn',
    scrollThreshold: false,
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

$(function() {
  $('.show-following').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    append : '.show-following .user-card',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    button: '.show-following-footer .loadmore-btn',
    scrollThreshold: false,
    path : '.show-following-footer nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    hideNav: '.show-following-footer .pagination'
  })
})

$(function() {
  $('.show-followers').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    append : '.show-followers .user-card',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    button: '.show-followers-footer .loadmore-btn',
    scrollThreshold: false,
    path : '.show-followers-footer nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    hideNav: '.show-followers-footer .pagination'
  })
})

$(function() {
  $('.show-follow').infiniteScroll({　　　// 監視してほしい範囲のタグのクラス
    append : '.show-follow .user-card',  // 読まれたら追加していくタグのクラス
    history: false,  // ページが読まれてもURLを変えない
    button: '.show-follow-footer .loadmore-btn',
    scrollThreshold: false,
    path : '.show-follow-footer nav.pagination a[rel=next]',  // 次ページのリンク(kaminari使ってる)
    hideNav: '.show-follow-footer .pagination'
  })
})