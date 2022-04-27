Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC17C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 03:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357313AbiD0Dic (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Apr 2022 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357536AbiD0Dia (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Apr 2022 23:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2213CC6
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 20:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB29160B8D
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 03:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21047C385A7;
        Wed, 27 Apr 2022 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651030518;
        bh=W4Hl3GiwtsitkH7Qw/D27R1voHAZF7RG06veeCGJnTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qq2bsVXA6yCLgD0xa/0vMCB1X/dHyJc8V9bnT8wyvH+fIGtiCpgQJc61CD4ZjJreI
         zOPkkgM2YS2suFqSbjeDOVSCj2lz2kERTikZK9rDqOQXpJ000wne80ZXuJB0BFHOXy
         O01nGOrON6l6AyZMlpuY7wABzfVGf91BwI3sSaxxeodEsb45K4Eij5QBbQt4wjOH0e
         4v59RbiWdfuzxULldhkNJTFfI9VvcJZu3dN2EFfCtlKwGiFMJGefKT38W7TuGPgckO
         +eCXXzz2/r20ly2XPMFMiCeQYSmiUPB+lj9zn2uZo/mFQREWHwRF6Bu2Sp7Hwp9xpu
         EugtK+d2Z359w==
Date:   Tue, 26 Apr 2022 20:35:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [RESEND] generic/673: Add separate sgid stripping sub-tests
Message-ID: <20220427033517.GI17014@magnolia>
References: <1650963345-2577-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650963345-2577-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 26, 2022 at 04:55:45PM +0800, Yang Xu wrote:
> Even kernel doesn't get ATTR_KILL_SGID mask and get ATTR_KILL_SUID mask,
> we still can strip S_ISGID mode in setattr_prepare and setattr_copy.
> 
> We should check separate sgid stripping logic whether works well
> on different filesystems.
> 
> Also fix comments error.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/673     | 37 ++++++++++++++++++++++++++++++-------
>  tests/generic/673.out | 24 ++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/673 b/tests/generic/673
> index 0377c5f6..e40e672a 100755
> --- a/tests/generic/673
> +++ b/tests/generic/673
> @@ -53,8 +53,7 @@ commit_and_check() {
>  	echo
>  }
>  
> -# Commit to a non-exec file by an unprivileged user clears suid but leaves
> -# sgid.
> +# Commit to a non-exec file by an unprivileged user clears suid and sgid
>  echo "Test 1 - qa_user, non-exec file"
>  setup_testfile
>  chmod a+rws $SCRATCH_MNT/a
> @@ -66,7 +65,7 @@ setup_testfile
>  chmod g+x,a+rws $SCRATCH_MNT/a
>  commit_and_check "$qa_user"
>  
> -# Commit to a user-exec file by an unprivileged user clears suid but not sgid.
> +# Commit to a user-exec file by an unprivileged user clears suid and sgid.
>  echo "Test 3 - qa_user, user-exec file"
>  setup_testfile
>  chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> @@ -78,30 +77,54 @@ setup_testfile
>  chmod a+rwxs $SCRATCH_MNT/a
>  commit_and_check "$qa_user"
>  
> -# Commit to a non-exec file by root clears suid but leaves sgid.
> +# Commit to a non-exec file by root leaves suid and sgid.
>  echo "Test 5 - root, non-exec file"
>  setup_testfile
>  chmod a+rws $SCRATCH_MNT/a
>  commit_and_check
>  
> -# Commit to a group-exec file by root clears suid and sgid.
> +# Commit to a group-exec file by root leaves suid and sgid.
>  echo "Test 6 - root, group-exec file"
>  setup_testfile
>  chmod g+x,a+rws $SCRATCH_MNT/a
>  commit_and_check
>  
> -# Commit to a user-exec file by root clears suid but not sgid.
> +# Commit to a user-exec file by root leaves suid and sgid.
>  echo "Test 7 - root, user-exec file"
>  setup_testfile
>  chmod u+x,a+rws,g-x $SCRATCH_MNT/a
>  commit_and_check
>  
> -# Commit to a all-exec file by root clears suid and sgid.
> +# Commit to a all-exec file by root leaves suid and sgid.
>  echo "Test 8 - root, all-exec file"
>  setup_testfile
>  chmod a+rwxs $SCRATCH_MNT/a
>  commit_and_check
>  
> +#Commit to a non-exec file by an unprivileged user leaves sgid.
> +echo "Test 9 - qa_user, non-exec file, only sgid"
> +setup_testfile
> +chmod a+rw,g+rws $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +#Commit to a group-exec file by an unprivileged user clears sgid
> +echo "Test 10 - qa_user, group-exec file, only sgid"
> +setup_testfile
> +chmod a+rw,g+rwxs $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +#Commit to a user-exec file by an unprivileged user clears sgid
> +echo "Test 11 - qa_user, user-exec file, only sgid"
> +setup_testfile
> +chmod a+rw,u+x,g+rws $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +#Commit to a all-exec file by an unprivileged user clears sgid.
> +echo "Test 12 - qa_user, all-exec file, only sgid"
> +setup_testfile
> +chmod a+rwx,g+rwxs $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/generic/673.out b/tests/generic/673.out
> index 4d18bca2..0817857d 100644
> --- a/tests/generic/673.out
> +++ b/tests/generic/673.out
> @@ -47,3 +47,27 @@ Test 8 - root, all-exec file
>  3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
>  6777 -rwsrwsrwx SCRATCH_MNT/a
>  
> +Test 9 - qa_user, non-exec file, only sgid
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +2666 -rw-rwSrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +2666 -rw-rwSrw- SCRATCH_MNT/a
> +
> +Test 10 - qa_user, group-exec file, only sgid
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +2676 -rw-rwsrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +676 -rw-rwxrw- SCRATCH_MNT/a
> +
> +Test 11 - qa_user, user-exec file, only sgid
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +2766 -rwxrwSrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +2766 -rwxrwSrw- SCRATCH_MNT/a
> +
> +Test 12 - qa_user, all-exec file, only sgid
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +2777 -rwxrwsrwx SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +777 -rwxrwxrwx SCRATCH_MNT/a
> +
> -- 
> 2.27.0
> 
