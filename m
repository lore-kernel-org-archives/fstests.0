Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62934C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 18:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiEJST5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiEJSTp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 14:19:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53362BA9BB
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 11:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C98B81F47
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 18:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADBDC385A6;
        Tue, 10 May 2022 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652206531;
        bh=mbTlldzUQOhx28MVxxqzopxclidhZvF5UuHR5mZlLQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUYUcLQvmfVCizCZ05WCNJZisyB2EG1SpoO0zGVgUVeQA2pIVZBxfWncwyWokj83x
         TM3ub8A1FOvjMzigAsxmUo/p028Tjx8WNRKyHyr/Xy25szVtKiFbcOJmAgFwA7lGgB
         x1f2V9d/nFse3wyJVo4G9NAXq0jMRjivnBzrsUgY26Cm1R0tAZlvLLEUk9km1SaCSC
         /3C/4x42wZNH7ulwk1uQNxpYfTNohKcY+JBJnB7v+jNEwmqUjrcoIegkCwz234+hLy
         Klz7INrrCfmikAGhl4at7v/iLxwnSLS7kOLrw9bI4WsXwN3Kek3KLnzrH1724C8zKc
         6Ooqhuoe2nn2g==
Date:   Tue, 10 May 2022 11:15:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/68[3-7]: Add separate sgid stripping sub-tests
Message-ID: <20220510181530.GA27174@magnolia>
References: <1652160290-2097-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652160290-2097-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 10, 2022 at 01:24:50PM +0800, Yang Xu wrote:
> Like xfstests commit 298f60c ("generic/673: Add separate sgid stripping sub-tests"),
> we should also add separate sgid stripping sub-tests for each fallocate operation.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Oops, thank you for catching up these tests.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/683     | 69 +++++++++++++++++++++++++------------------
>  tests/generic/683.out | 16 ++++++++++
>  tests/generic/684     | 69 +++++++++++++++++++++++++------------------
>  tests/generic/684.out | 16 ++++++++++
>  tests/generic/685     | 69 +++++++++++++++++++++++++------------------
>  tests/generic/685.out | 16 ++++++++++
>  tests/generic/686     | 69 +++++++++++++++++++++++++------------------
>  tests/generic/686.out | 16 ++++++++++
>  tests/generic/687     | 69 +++++++++++++++++++++++++------------------
>  tests/generic/687.out | 16 ++++++++++
>  10 files changed, 280 insertions(+), 145 deletions(-)
> 
> diff --git a/tests/generic/683 b/tests/generic/683
> index c512989b..746ead86 100755
> --- a/tests/generic/683
> +++ b/tests/generic/683
> @@ -61,67 +61,78 @@ commit_and_check() {
>  	echo
>  }
>  
> -nr=0
> -# Commit to a non-exec file by an unprivileged user clears suid but
> -# leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, non-exec file $verb"
> +# Commit to a non-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 1 - qa_user, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, group-exec file $verb"
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears suid but
> -# not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, user-exec file $verb"
> +# Commit to a user-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 3 - qa_user, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, all-exec file $verb"
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by root clears suid but leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, non-exec file $verb"
> +# Commit to a non-exec file by root leaves suid and sgid.
> +echo "Test 5 - root, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, group-exec file $verb"
> +# Commit to a group-exec file by root leaves suid and sgid.
> +echo "Test 6 - root, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by root clears suid but not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, user-exec file $verb"
> +# Commit to a user-exec file by root leaves suid and sgid.
> +echo "Test 7 - root, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, all-exec file $verb"
> +# Commit to a all-exec file by root leaves suid and sgid.
> +echo "Test 8 - root, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> +# Commit to a non-exec file by an unprivileged user leaves sgid.
> +echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a group-exec file by an unprivileged user clears sgid
> +echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a user-exec file by an unprivileged user clears sgid
> +echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,u+x,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a all-exec file by an unprivileged user clears sgid.
> +echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rwx,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/683.out b/tests/generic/683.out
> index 9d1c9f80..ca29f6e6 100644
> --- a/tests/generic/683.out
> +++ b/tests/generic/683.out
> @@ -31,3 +31,19 @@ Test 8 - root, all-exec file falloc
>  6777 -rwsrwsrwx TEST_DIR/683/a
>  6777 -rwsrwsrwx TEST_DIR/683/a
>  
> +Test 9 - qa_user, non-exec file falloc, only sgid
> +2666 -rw-rwSrw- TEST_DIR/683/a
> +2666 -rw-rwSrw- TEST_DIR/683/a
> +
> +Test 10 - qa_user, group-exec file falloc, only sgid
> +2676 -rw-rwsrw- TEST_DIR/683/a
> +676 -rw-rwxrw- TEST_DIR/683/a
> +
> +Test 11 - qa_user, user-exec file falloc, only sgid
> +2766 -rwxrwSrw- TEST_DIR/683/a
> +2766 -rwxrwSrw- TEST_DIR/683/a
> +
> +Test 12 - qa_user, all-exec file falloc, only sgid
> +2777 -rwxrwsrwx TEST_DIR/683/a
> +777 -rwxrwxrwx TEST_DIR/683/a
> +
> diff --git a/tests/generic/684 b/tests/generic/684
> index d59f4239..4bebeff0 100755
> --- a/tests/generic/684
> +++ b/tests/generic/684
> @@ -61,67 +61,78 @@ commit_and_check() {
>  	echo
>  }
>  
> -nr=0
> -# Commit to a non-exec file by an unprivileged user clears suid but
> -# leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, non-exec file $verb"
> +# Commit to a non-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 1 - qa_user, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, group-exec file $verb"
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears suid but
> -# not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, user-exec file $verb"
> +# Commit to a user-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 3 - qa_user, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, all-exec file $verb"
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by root clears suid but leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, non-exec file $verb"
> +# Commit to a non-exec file by root leaves suid and sgid.
> +echo "Test 5 - root, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, group-exec file $verb"
> +# Commit to a group-exec file by root leaves suid and sgid.
> +echo "Test 6 - root, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by root clears suid but not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, user-exec file $verb"
> +# Commit to a user-exec file by root leaves suid and sgid.
> +echo "Test 7 - root, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, all-exec file $verb"
> +# Commit to a all-exec file by root leaves suid and sgid.
> +echo "Test 8 - root, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> +# Commit to a non-exec file by an unprivileged user leaves sgid.
> +echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a group-exec file by an unprivileged user clears sgid
> +echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a user-exec file by an unprivileged user clears sgid
> +echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,u+x,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a all-exec file by an unprivileged user clears sgid.
> +echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rwx,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/684.out b/tests/generic/684.out
> index df5b3788..2e084ced 100644
> --- a/tests/generic/684.out
> +++ b/tests/generic/684.out
> @@ -31,3 +31,19 @@ Test 8 - root, all-exec file fpunch
>  6777 -rwsrwsrwx TEST_DIR/684/a
>  6777 -rwsrwsrwx TEST_DIR/684/a
>  
> +Test 9 - qa_user, non-exec file fpunch, only sgid
> +2666 -rw-rwSrw- TEST_DIR/684/a
> +2666 -rw-rwSrw- TEST_DIR/684/a
> +
> +Test 10 - qa_user, group-exec file fpunch, only sgid
> +2676 -rw-rwsrw- TEST_DIR/684/a
> +676 -rw-rwxrw- TEST_DIR/684/a
> +
> +Test 11 - qa_user, user-exec file fpunch, only sgid
> +2766 -rwxrwSrw- TEST_DIR/684/a
> +2766 -rwxrwSrw- TEST_DIR/684/a
> +
> +Test 12 - qa_user, all-exec file fpunch, only sgid
> +2777 -rwxrwsrwx TEST_DIR/684/a
> +777 -rwxrwxrwx TEST_DIR/684/a
> +
> diff --git a/tests/generic/685 b/tests/generic/685
> index 2e990465..03447e00 100755
> --- a/tests/generic/685
> +++ b/tests/generic/685
> @@ -61,67 +61,78 @@ commit_and_check() {
>  	echo
>  }
>  
> -nr=0
> -# Commit to a non-exec file by an unprivileged user clears suid but
> -# leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, non-exec file $verb"
> +# Commit to a non-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 1 - qa_user, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, group-exec file $verb"
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears suid but
> -# not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, user-exec file $verb"
> +# Commit to a user-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 3 - qa_user, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, all-exec file $verb"
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by root clears suid but leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, non-exec file $verb"
> +# Commit to a non-exec file by root leaves suid and sgid.
> +echo "Test 5 - root, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, group-exec file $verb"
> +# Commit to a group-exec file by root leaves suid and sgid.
> +echo "Test 6 - root, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by root clears suid but not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, user-exec file $verb"
> +# Commit to a user-exec file by root leaves suid and sgid.
> +echo "Test 7 - root, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, all-exec file $verb"
> +# Commit to a all-exec file by root leaves suid and sgid.
> +echo "Test 8 - root, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> +# Commit to a non-exec file by an unprivileged user leaves sgid.
> +echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a group-exec file by an unprivileged user clears sgid
> +echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a user-exec file by an unprivileged user clears sgid
> +echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,u+x,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a all-exec file by an unprivileged user clears sgid.
> +echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rwx,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/685.out b/tests/generic/685.out
> index 90b7a0de..e611da3e 100644
> --- a/tests/generic/685.out
> +++ b/tests/generic/685.out
> @@ -31,3 +31,19 @@ Test 8 - root, all-exec file fzero
>  6777 -rwsrwsrwx TEST_DIR/685/a
>  6777 -rwsrwsrwx TEST_DIR/685/a
>  
> +Test 9 - qa_user, non-exec file fzero, only sgid
> +2666 -rw-rwSrw- TEST_DIR/685/a
> +2666 -rw-rwSrw- TEST_DIR/685/a
> +
> +Test 10 - qa_user, group-exec file fzero, only sgid
> +2676 -rw-rwsrw- TEST_DIR/685/a
> +676 -rw-rwxrw- TEST_DIR/685/a
> +
> +Test 11 - qa_user, user-exec file fzero, only sgid
> +2766 -rwxrwSrw- TEST_DIR/685/a
> +2766 -rwxrwSrw- TEST_DIR/685/a
> +
> +Test 12 - qa_user, all-exec file fzero, only sgid
> +2777 -rwxrwsrwx TEST_DIR/685/a
> +777 -rwxrwxrwx TEST_DIR/685/a
> +
> diff --git a/tests/generic/686 b/tests/generic/686
> index 71c3aebb..eae3cbda 100755
> --- a/tests/generic/686
> +++ b/tests/generic/686
> @@ -61,67 +61,78 @@ commit_and_check() {
>  	echo
>  }
>  
> -nr=0
> -# Commit to a non-exec file by an unprivileged user clears suid but
> -# leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, non-exec file $verb"
> +# Commit to a non-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 1 - qa_user, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, group-exec file $verb"
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears suid but
> -# not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, user-exec file $verb"
> +# Commit to a user-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 3 - qa_user, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, all-exec file $verb"
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by root clears suid but leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, non-exec file $verb"
> +# Commit to a non-exec file by root leaves suid and sgid.
> +echo "Test 5 - root, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, group-exec file $verb"
> +# Commit to a group-exec file by root leaves suid and sgid.
> +echo "Test 6 - root, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by root clears suid but not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, user-exec file $verb"
> +# Commit to a user-exec file by root leaves suid and sgid.
> +echo "Test 7 - root, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, all-exec file $verb"
> +# Commit to a all-exec file by root leaves suid and sgid.
> +echo "Test 8 - root, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> +# Commit to a non-exec file by an unprivileged user leaves sgid.
> +echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a group-exec file by an unprivileged user clears sgid
> +echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a user-exec file by an unprivileged user clears sgid
> +echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,u+x,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a all-exec file by an unprivileged user clears sgid.
> +echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rwx,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/686.out b/tests/generic/686.out
> index 6a1179f1..aa1e6471 100644
> --- a/tests/generic/686.out
> +++ b/tests/generic/686.out
> @@ -31,3 +31,19 @@ Test 8 - root, all-exec file finsert
>  6777 -rwsrwsrwx TEST_DIR/686/a
>  6777 -rwsrwsrwx TEST_DIR/686/a
>  
> +Test 9 - qa_user, non-exec file finsert, only sgid
> +2666 -rw-rwSrw- TEST_DIR/686/a
> +2666 -rw-rwSrw- TEST_DIR/686/a
> +
> +Test 10 - qa_user, group-exec file finsert, only sgid
> +2676 -rw-rwsrw- TEST_DIR/686/a
> +676 -rw-rwxrw- TEST_DIR/686/a
> +
> +Test 11 - qa_user, user-exec file finsert, only sgid
> +2766 -rwxrwSrw- TEST_DIR/686/a
> +2766 -rwxrwSrw- TEST_DIR/686/a
> +
> +Test 12 - qa_user, all-exec file finsert, only sgid
> +2777 -rwxrwsrwx TEST_DIR/686/a
> +777 -rwxrwxrwx TEST_DIR/686/a
> +
> diff --git a/tests/generic/687 b/tests/generic/687
> index 7bdfcd5c..0bd421e5 100755
> --- a/tests/generic/687
> +++ b/tests/generic/687
> @@ -61,67 +61,78 @@ commit_and_check() {
>  	echo
>  }
>  
> -nr=0
> -# Commit to a non-exec file by an unprivileged user clears suid but
> -# leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, non-exec file $verb"
> +# Commit to a non-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 1 - qa_user, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, group-exec file $verb"
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by an unprivileged user clears suid but
> -# not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, user-exec file $verb"
> +# Commit to a user-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 3 - qa_user, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by an unprivileged user clears suid and
> -# sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - qa_user, all-exec file $verb"
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "$qa_user" "$verb" 64k 64k
>  
> -# Commit to a non-exec file by root clears suid but leaves sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, non-exec file $verb"
> +# Commit to a non-exec file by root leaves suid and sgid.
> +echo "Test 5 - root, non-exec file $verb"
>  setup_testfile
>  chmod a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a group-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, group-exec file $verb"
> +# Commit to a group-exec file by root leaves suid and sgid.
> +echo "Test 6 - root, group-exec file $verb"
>  setup_testfile
>  chmod g+x,a+rws $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a user-exec file by root clears suid but not sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, user-exec file $verb"
> +# Commit to a user-exec file by root leaves suid and sgid.
> +echo "Test 7 - root, user-exec file $verb"
>  setup_testfile
>  chmod u+x,a+rws,g-x $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> -# Commit to a all-exec file by root clears suid and sgid.
> -nr=$((nr + 1))
> -echo "Test $nr - root, all-exec file $verb"
> +# Commit to a all-exec file by root leaves suid and sgid.
> +echo "Test 8 - root, all-exec file $verb"
>  setup_testfile
>  chmod a+rwxs $junk_file
>  commit_and_check "" "$verb" 64k 64k
>  
> +# Commit to a non-exec file by an unprivileged user leaves sgid.
> +echo "Test 9 - qa_user, non-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a group-exec file by an unprivileged user clears sgid
> +echo "Test 10 - qa_user, group-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a user-exec file by an unprivileged user clears sgid
> +echo "Test 11 - qa_user, user-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rw,u+x,g+rws $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
> +# Commit to a all-exec file by an unprivileged user clears sgid.
> +echo "Test 12 - qa_user, all-exec file $verb, only sgid"
> +setup_testfile
> +chmod a+rwx,g+rwxs $junk_file
> +commit_and_check "$qa_user" "$verb" 64k 64k
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/687.out b/tests/generic/687.out
> index 7f945d72..c5116c27 100644
> --- a/tests/generic/687.out
> +++ b/tests/generic/687.out
> @@ -31,3 +31,19 @@ Test 8 - root, all-exec file fcollapse
>  6777 -rwsrwsrwx TEST_DIR/687/a
>  6777 -rwsrwsrwx TEST_DIR/687/a
>  
> +Test 9 - qa_user, non-exec file fcollapse, only sgid
> +2666 -rw-rwSrw- TEST_DIR/687/a
> +2666 -rw-rwSrw- TEST_DIR/687/a
> +
> +Test 10 - qa_user, group-exec file fcollapse, only sgid
> +2676 -rw-rwsrw- TEST_DIR/687/a
> +676 -rw-rwxrw- TEST_DIR/687/a
> +
> +Test 11 - qa_user, user-exec file fcollapse, only sgid
> +2766 -rwxrwSrw- TEST_DIR/687/a
> +2766 -rwxrwSrw- TEST_DIR/687/a
> +
> +Test 12 - qa_user, all-exec file fcollapse, only sgid
> +2777 -rwxrwsrwx TEST_DIR/687/a
> +777 -rwxrwxrwx TEST_DIR/687/a
> +
> -- 
> 2.27.0
> 
