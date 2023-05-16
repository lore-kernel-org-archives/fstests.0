Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA7C7EE25
	for <linux-fstests@archiver.kernel.org>; Tue, 16 May 2023 14:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjEPOyl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 May 2023 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjEPOyk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2023 10:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6ED46AD
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 07:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F5362F54
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 14:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8008CC433EF;
        Tue, 16 May 2023 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684248877;
        bh=TTF3KV7DUsTXUOmTnSGihJ3wIoNq8MCmzxGFkpc7g/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTgtE+5YBYNRdr6kYBWtEpSL2AgH3LqSoDi2e7K0s+F9ealkAGMHK/3Wo3Eem3mhk
         nHvVzuGRVCNKfK2zs2jg/uC9ex83I4rOcwlDMWTjis9BRRoFsSt0SD2o3G/m07gIIJ
         yg5Ifi3jhLy0CQWXcAE9/ffauzrIG0EgN/uektLBivUoVURY9ykbD3Zj/wrYN/hpMN
         NrzCRjKk9pVuLEJ37ljijN9Ld/5HQyugv7lYG70Nbd44AIIRAZJaE+Zac6/YmX9Xve
         jT/C8Uk+lBLPycrkC8ZWlUMZsvnsouNubV8ip6khFtN8xVgJ1P7G19O7VBIDKO0+Ce
         vZUlgPEU3SzLw==
Date:   Tue, 16 May 2023 07:54:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] fstests: fix compilation error in splice2pipe on old
 (<C99) compilers
Message-ID: <20230516145437.GA858795@frogsfrogsfrogs>
References: <20230516102301.571503-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516102301.571503-1-aalbersh@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 16, 2023 at 12:23:03PM +0200, Andrey Albershteyn wrote:
> Compilation fails on system with compiler which uses older C dialect
> (e.g. RHEL7; gcc with gnu90) with:
> 
> splice2pipe.c: In function 'prepare_pipe':
> splice2pipe.c:54:2: error: 'for' loop initial declarations are only allowed in C99 mode
>   for (unsigned r = pipe_size; r > 0;) {
> 
> Fix it by declaring 'r' outside of the loop.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Not sure if you need to zero-init the variable, but eh looks good to me

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/splice2pipe.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/splice2pipe.c b/src/splice2pipe.c
> index bd33ff67..00b3a23a 100644
> --- a/src/splice2pipe.c
> +++ b/src/splice2pipe.c
> @@ -41,6 +41,7 @@
>   */
>  static void prepare_pipe(int p[2])
>  {
> +	unsigned int r = 0;
>  	if (pipe(p)) {
>  		perror("pipe failed");
>  		abort();
> @@ -51,7 +52,7 @@ static void prepare_pipe(int p[2])
>  
>  	/* fill the pipe completely; each pipe_buffer will now have
>  	   the PIPE_BUF_FLAG_CAN_MERGE flag */
> -	for (unsigned r = pipe_size; r > 0;) {
> +	for (r = pipe_size; r > 0;) {
>  		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
>  		write(p[1], buffer, n);
>  		r -= n;
> @@ -59,7 +60,7 @@ static void prepare_pipe(int p[2])
>  
>  	/* drain the pipe, freeing all pipe_buffer instances (but
>  	   leaving the flags initialized) */
> -	for (unsigned r = pipe_size; r > 0;) {
> +	for (r = pipe_size; r > 0;) {
>  		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
>  		read(p[0], buffer, n);
>  		r -= n;
> -- 
> 2.31.1
> 
