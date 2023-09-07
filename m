Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B5FEC873D
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Sep 2023 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjIGQbs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIGQbe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2023 12:31:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85149C3
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 09:21:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF29EC116A1;
        Thu,  7 Sep 2023 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694082351;
        bh=jB+ybBjH6jlGmHlZPWIhiid0tEG8KKIzNUrePMS7vE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJ0bqDZWwdc+d1hACjP7duUCbc5+OLmV/7F3iVJdLnOtY5+Ooe++GNiwIAdNQZKXD
         gIDIkOqVrD+HMghoYhx5M6dGE3g7qOpt9XvmpVut1XURIIgbiqm3ZZjfXws/y2A6bU
         +EmN7L0Cfuq7ZvtjYPp0MWxv2RSeIx1wY4DBpJxCwH5JiKvr3sqQhnRVYXHAOtz/9Q
         2ROm5IO3AzEIOmW3siChiR+2WWnpE+XA1jk1tBbSQv/oNWHOnga2x2MasEvah2eRhQ
         6V5xaKSYCisjtpxIrC8xEw5XvHVrASYpSEP/Q/UJx2QydCUxQwR6K9JwOTp9vtf0tl
         60nsgE8KxVONA==
Date:   Thu, 7 Sep 2023 18:25:47 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] tools/mvtest: ensure testcase is executable (755)
Message-ID: <20230907102547.zv53cena4mxmbk5w@zlang-mailbox>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 06, 2023 at 03:13:49PM +0800, Shiyang Ruan wrote:
> Some test cases lack executable permission ('x'). Before running each
> test case, `./check` checks and grants them 'x' permission. However,
> this always leads to a dirty git repo. And the absence of 'x' permission
> in test cases is often overlooked during reviews.
> 
> Since maintainers use mvtest to assign new case, add this change for
> convenience of maintainers.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tools/mvtest | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mvtest b/tools/mvtest
> index 99b154142..e839f0256 100755
> --- a/tools/mvtest
> +++ b/tools/mvtest
> @@ -28,6 +28,8 @@ append() {
>  test "${src}" != "${dest}" || die "Test \"${src}\" is the same as dest."
>  test -e "tests/${src}" || die "Test \"${src}\" does not exist."
>  test ! -e "tests/${dest}" || die "Test \"${src}\" already exists."
> +# make sure testcase is executable
> +test `stat -c '%a' tests/${src}` == 755 || chmod 755 "tests/${src}"

I think we can check and set the file permission on the target file after the
move operation done, not the source file.

And we recommend using $() to replace ``, if both of them work.

Thanks,
Zorro

>  
>  sid="$(basename "${src}")"
>  did="$(basename "${dest}")"
> -- 
> 2.42.0
> 
