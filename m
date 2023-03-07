Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E7DC6FD1A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjCGQuj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCGQuI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:50:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA25D25B8F
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 532A7614D1
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5595C433EF;
        Tue,  7 Mar 2023 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207573;
        bh=z6iP2Jtx1rE9bN4QDYfePI25heMqgzscbpHSJBJooLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0vXzIAJB7EEh4I+eMStPx1BN22lDzt0VvoMdRinE4IqrXRCNp72yZ+i3rhNGKAb+
         +EKhaopoYOyf7m9hRIrPI5aHbJGbIgYEcw27jcbHNBAsh1R8kDqMaI8SaTTMHcb/vk
         FU7xnLrz2PLhP9yWkqFOtFcfwiYMeKZaBiC5XsV2pjoWdjXitWys9OSnYuRq5/dVAe
         oJFtY4WLdvidU3HGfA/qnRYVqZn8ktapzgpuZZMHCGmaw71QSPMQbLy3zA6hgLGwYI
         z/bSiQfkAI5cERnGaijRurtwt9XtHLTLokFhkz2Y+u5olyyVTPO532En3ElJzNWMxi
         vpiNZFOL0DnaA==
Date:   Tue, 7 Mar 2023 17:46:04 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 03/11] vfs: Fix race condition on get_userns_fd()
Message-ID: <20230307164604.guofenicecdtlsxl@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-4-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-4-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:44:59PM +0100, Rodrigo Campos wrote:
> Talking with Christian Brauner about a different problem, he mentioned
> that technically this race condition exists and we should fix it.
> 
> The race is that when we clone, we call a function that just returns
> while at the same time we try to get the userns via /proc/pid/ns/user.
> The thing is that, while the pid needs to be reaped, Christian said that
> the userns file cease to exist as soon as the program finishes.

See exit_task_namespaces() in kernel/exit.c:do_exit().

> 
> So, let's make the function never return, so we always can get the
> userns. We are already sending a SIGKILL to this pid, so nothing else
> remaining to not leak the process.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  src/vfs/utils.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git src/vfs/utils.c src/vfs/utils.c
> index ea7536c1..67779e83 100644
> --- src/vfs/utils.c
> +++ src/vfs/utils.c
> @@ -58,9 +58,10 @@ pid_t do_clone(int (*fn)(void *), void *arg, int flags)
>  #endif
>  }
>  
> -static int get_userns_fd_cb(void *data)
> +__attribute__((noreturn)) static int get_userns_fd_cb(void *data)
>  {
> -	return 0;
> +	for (;;)
> +		pause();

Should this add a _exit(0)? It's pretty odd otherwise. And do we need
noreturn?
