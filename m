Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A802EB64DC
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Jul 2023 23:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGKXom (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Jul 2023 19:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGKXom (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jul 2023 19:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FA170F
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 16:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D897B61625
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2023 23:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F942C433C7;
        Tue, 11 Jul 2023 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689119080;
        bh=3e9tp5kJWRT8LXVcSrBqX0EPDALHyzH0yaD1yRgssUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRGW4ylrFDNvduC0Ws0/4d0ScVhOw+IbjDI9qBLESlhROAcDSyleqDEqjqWxH9dXY
         Yx82fOkhPgT6kJQFF38KW0zTJ92QMILklUH+v7K5dnwF/2fPHeC5kQRk39zIvrICfB
         Cnj5CX7CRpIZOZFmq9hWbSKquD/bmFuqBQE1A7eVEn91QRzX0Nm7N+UwpAB4z85IKw
         FWUQhnUtRfGf5/GHpHldV05RyGJ53t7t+AVQes5XmZmLUKbcudSmlnlLvwbHomsGQ1
         nifyJvRoallzH3yKKhO1O9y1FXK4xRayFu1QelbL2nhP4zaih5Osi/N9j5DKxc3ktC
         r6GsHqDAyiTdA==
Date:   Tue, 11 Jul 2023 16:44:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230711234439.GC11442@frogsfrogsfrogs>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> When I run the test 558 on bcachefs, it works like a fork-bomb and kills
> the machine. The reason is that the "while" loop spawns "create_file"
> subprocesses faster than they are able to complete.
> 
> This patch fixes the crash by limiting the number of subprocesses to 128.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  tests/generic/558 |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: xfstests-dev/tests/generic/558
> ===================================================================
> --- xfstests-dev.orig/tests/generic/558
> +++ xfstests-dev/tests/generic/558
> @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
>  while [ $i -lt $loop ]; do
>  	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
>  	let i=$i+1
> +	if [ $((i % 128)) = 0 ]; then wait; fi

Hm.  $loop is (roughly) the number of free inodes divided by 1000.  This
test completes nearly instantly on XFS; how many free inodes does
bcachefs report after _scratch_mount?

XFS reports ~570k inodes, so it's "only" starting 570 processes.

I think it's probably wise to clamp $loop to something sane, but let's
get to the bottom of how the math went wrong and we got a forkbomb.

--D

>  done
>  wait
>  
> 
