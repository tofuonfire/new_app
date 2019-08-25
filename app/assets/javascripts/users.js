// 全ユーザーの一覧
$(function() {
  $('.all-users').infiniteScroll({
    append : '.all-users .user-card',
    button: '.all-users-footer .loadmore-btn',
    path : '.all-users-footer nav.pagination a[rel=next]',
    hideNav: '.all-users-footer .pagination',
    scrollThreshold: false,
    history: false
  })
})
$(function () {
  if($(".all-users-footer nav.pagination")[0]) {
  } else {
      $(".all-users-footer .loadmore-btn").hide();
  }
});

// ユーザー詳細ページ
  // 投稿
  $(function() {
    $('.show-latest').infiniteScroll({
      path : '.show-latest-footer nav.pagination a[rel=next]',
      append : '.show-latest .post-card',
      history: false,
      button: '.show-latest-footer .loadmore-btn',
      scrollThreshold: false,
      hideNav: '.show-latest-footer .pagination'
    })
  })
  $(function () {
    if($(".show-latest-footer nav.pagination")[0]) {
    } else {
        $(".show-latest-footer .loadmore-btn").hide();
    }
  });

  // フォロー中
  $(function() {
    $('.show-following').infiniteScroll({
      append : '.show-following .user-card',
      history: false,
      button: '.show-following-footer .loadmore-btn',
      scrollThreshold: false,
      path : '.show-following-footer nav.pagination a[rel=next]',
      hideNav: '.show-following-footer .pagination'
    })
  })
  $(function () {
    if($(".show-following-footer nav.pagination")[0]) {
    } else {
        $(".show-following-footer .loadmore-btn").hide();
    }
  });

  // フォロワー
  $(function() {
    $('.show-followers').infiniteScroll({
      append : '.show-followers .user-card',
      history: false,
      button: '.show-followers-footer .loadmore-btn',
      scrollThreshold: false,
      path : '.show-followers-footer nav.pagination a[rel=next]',
      hideNav: '.show-followers-footer .pagination'
    })
  })
  $(function () {
    if($(".show-followers-footer nav.pagination")[0]) {
    } else {
        $(".show-followers-footer .loadmore-btn").hide();
    }
  });

  // いいね
  $(function() {
    $('.show-likes').infiniteScroll({
      path : '.show-likes-footer nav.pagination a[rel=next]',
      append : '.show-likes .post-card',
      history: false,
      button: '.show-likes-footer .loadmore-btn',
      scrollThreshold: false,
      hideNav: '.show-likes-footer .pagination'
    })
  })
  $(function () {
    if($(".show-likes-footer nav.pagination")[0]) {
    } else {
        $(".show-likes-footer .loadmore-btn").hide();
    }
  });
