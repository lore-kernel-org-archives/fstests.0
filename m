Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B4C678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 17:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCGRAV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCGQ6r (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:58:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792F159C5
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:55:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 005D8614E1
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A6C433D2;
        Tue,  7 Mar 2023 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678208112;
        bh=3epKT6Jk7Um+TfBsMcmrYFKaDWqyy6Cpk+eLOfViFec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBEOGg/GhXI1TgTmEayoOvi43FfWH+aK6kB4I3XDAJt37+Cs8jOurCAFSzFxnpbZN
         3g3ad7osQMdjN/fLtU1t+X3B1hc47ANAT6jXfzLXKAvLRBAf7AfHJxi6ECVQATQyoy
         8X8lgnCEVG21HkEfCphVdbsZh/g5edMiZXIMGgyAompC6v1QkadJR0u1SzUk6GjsBK
         hXMuPPcd/0EnMzAFje6EVMnBlkdAXZl2mE2qR9ef+cAzPpk13hFpJH3DPO3j3Y7Hoy
         vooEWx3HOFvTTCUGJlaL6jiRIf/J3C2aGXwkFd4/yD/FfczNGQS00Hl+f0uslfM5uJ
         +gqkb7MaBfAbA==
Date:   Tue, 7 Mar 2023 17:55:08 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 11/11] vfs: Use tabs to indent, not spaces
Message-ID: <20230307165508.77ptsmv2zdotw6xg@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-12-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-12-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:45:07PM +0100, Rodrigo Campos wrote:
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---

I think I explicitly used spaces but I don't know why anymore tbh. So
I'll live that to Zorro whether he wants to take this patch or not. I
have no strong opinion. :)

>  src/vfs/vfstest.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git src/vfs/vfstest.c src/vfs/vfstest.c
> index 3d75b1e3..dea344cc 100644
> --- src/vfs/vfstest.c
> +++ src/vfs/vfstest.c
> @@ -107,7 +107,7 @@ static int hardlink_crossing_mounts(const struct vfstest_info *info)
>  	int fret = -1;
>  	int file1_fd = -EBADF, open_tree_fd = -EBADF;
>  
> -        if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
> +	if (chown_r(info->t_mnt_fd, T_DIR1, 10000, 10000)) {
>  		log_stderr("failure: chown_r");
>  		goto out;
>  	}
> @@ -2307,22 +2307,22 @@ static void usage(void)
>  	fprintf(stderr, "    Run idmapped mount tests\n\n");
>  
>  	fprintf(stderr, "Arguments:\n");
> -	fprintf(stderr, "--device                            Device used in the tests\n");
> -	fprintf(stderr, "--fstype                            Filesystem type used in the tests\n");
> -	fprintf(stderr, "--help                              Print help\n");
> -	fprintf(stderr, "--mountpoint                        Mountpoint of device\n");
> -	fprintf(stderr, "--idmapped-mounts-supported         Test whether idmapped mounts are supported on this filesystem\n");
> -	fprintf(stderr, "--scratch-mountpoint                Mountpoint of scratch device used in the tests\n");
> -	fprintf(stderr, "--scratch-device                    Scratch device used in the tests\n");
> -	fprintf(stderr, "--test-core                         Run core idmapped mount testsuite\n");
> -	fprintf(stderr, "--test-fscaps-regression            Run fscap regression tests\n");
> -	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
> -	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
> -	fprintf(stderr, "--test-tmpfs                        Run tmpfs specific idmapped mount testsuite\n");
> +	fprintf(stderr, "--device			     Device used in the tests\n");
> +	fprintf(stderr, "--fstype			     Filesystem type used in the tests\n");
> +	fprintf(stderr, "--help				     Print help\n");
> +	fprintf(stderr, "--mountpoint			     Mountpoint of device\n");
> +	fprintf(stderr, "--idmapped-mounts-supported	     Test whether idmapped mounts are supported on this filesystem\n");
> +	fprintf(stderr, "--scratch-mountpoint		     Mountpoint of scratch device used in the tests\n");
> +	fprintf(stderr, "--scratch-device		     Scratch device used in the tests\n");
> +	fprintf(stderr, "--test-core			     Run core idmapped mount testsuite\n");
> +	fprintf(stderr, "--test-fscaps-regression	     Run fscap regression tests\n");
> +	fprintf(stderr, "--test-nested-userns		     Run nested userns idmapped mount testsuite\n");
> +	fprintf(stderr, "--test-btrfs			     Run btrfs specific idmapped mount testsuite\n");
> +	fprintf(stderr, "--test-tmpfs			     Run tmpfs specific idmapped mount testsuite\n");
>  	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
>  	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
> -	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
> -	fprintf(stderr, "--test-setgid-create-acl            Run setgid with acl tests\n");
> +	fprintf(stderr, "--test-setgid-create-umask	     Run setgid with umask tests\n");
> +	fprintf(stderr, "--test-setgid-create-acl	     Run setgid with acl tests\n");
>  
>  	_exit(EXIT_SUCCESS);
>  }
> -- 
> 2.39.2
> 
