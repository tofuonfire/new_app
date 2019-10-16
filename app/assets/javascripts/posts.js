// 投稿詳細ページのいいねしたユーザー一覧
$(function() {
  $('.post-likes').infiniteScroll({
    append : '.post-likes .user-card',
    history: false,
    button: '.post-likes-footer .loadmore-btn',
    scrollThreshold: false,
    path : '.post-likes-footer nav.pagination a[rel=next]',
    hideNav: '.post-likes-footer .pagination'
  })
})
$(function () {
  if($(".post-likes-footer nav.pagination")[0]) {
  } else {
      $(".post-likes-footer .loadmore-btn").hide();
  }
});

// 投稿検索ページ
$(function() {
  $('.post-cards.search').infiniteScroll({
    path : '.post-cards-footer.search nav.pagination a[rel=next]',
    append : '.post-cards.search .post-card',
    history: false,
    prefill: true,
    button: '.post-cards-footer.search .loadmore-btn',
    scrollThreshold: false,
    hideNav: '.post-cards-footer.search .pagination'
  })
})
$(function () {
  if($(".post-cards-footer.search nav.pagination")[0]) {
  } else {
      $(".post-cards-footer.search .loadmore-btn").hide();
  }
});