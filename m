Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBFAC6FD19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 10:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjCMKkP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCMKkN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 06:40:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3275FEB5
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 03:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F67FCE0C4F
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 10:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40F9C433D2;
        Mon, 13 Mar 2023 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678703992;
        bh=C8ju3NvXcys9AQvkfAffq1I0CsUuuZZXq01L7RHZPxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fU9GClqEZBeY1/HhQub4+gVuG9JaUaackeJuwRf1ooscXIlvN0FxxjPjaeIaexemI
         t0Livv/JpTH2qhRetawz3BpynE02txuPU4p+xKIY6NxOCgEi1FwwmIBXwoAkZVxXZW
         1eVWcSN5vtn71p/pI7K9a6JHT/O3Cbq1i35Kaub+MwmSc5WNehtOKX862cVjpimd0B
         wlkE2w8uunw2GJRCZwAm4XtpF5sHTteP6Q9kxOdz/20WSHnOX0oWTP0fUrnSbp66sB
         LXlYe/iZaDfCy9dnoex1YBIcb9z8COUEde9yXlOKJWoatZFcCxSlTsldJ4d6ci08n2
         b0XoBz6k+F6ng==
Date:   Mon, 13 Mar 2023 11:39:48 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v2 4/9] vfs: Fix race condition on get_userns_fd()
Message-ID: <20230313103948.cxukrx4rcidw4xsj@wittgenstein>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
 <20230308111343.510970-5-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308111343.510970-5-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 08, 2023 at 12:13:38PM +0100, Rodrigo Campos wrote:
> There is a race when we clone: we call a function that just returns
> while at the same time we try to get the userns via /proc/pid/ns/user.
> The thing is that when the function returns, in the kernel do_exit()
> from kernel/exit.c is called, which calls exit_task_namespaces() to destroy
> the namespaces.
> 
> So, let's wait indefinitely there and add an _exit() call to avoid
> warnings. We are already sending a SIGKILL to this pid, so nothing else
> remaining to not leak the process.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
