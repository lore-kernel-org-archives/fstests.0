Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F062AC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Nov 2021 02:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE7161A89
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Nov 2021 02:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhKPCFf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Nov 2021 21:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240023AbhKOSF3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 15 Nov 2021 13:05:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8C3A6324B;
        Mon, 15 Nov 2021 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636998093;
        bh=BOrx1j8g6kH/Eb6ZEJ58DgWkxWRNWqTbikjWK6WbkPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twS7i+78p2ovnYlY1+dgk3qbAXVCfX/AmZq75oj8CyZwRgE20T/LPNLQNWsbi9M8W
         IQ8tzTBwBLOLqUJmFl7voE9Qz+x1KhwOAvKu2+QQrZ5O4JmXDw/Xn/jWXrj/EghVGj
         ieKP0PuxcfAw7/vuoHzeyV25jIwLcNAEf9aqMeZIetLBN9efetwP9EAzL20bfHQMVn
         19NJwevLTcrypnQ6rfx59ame9N6YOlhLfkvWX6NGe+1i4NW9nxKnRuGCo7n+h2pehp
         TyS7j8H+nnuMMwtOlTJmjU9oy8HKDERFxQHb5A09R+09MBmKS2go91RtefJoz3kwns
         ggYiAuqbgtVMg==
Date:   Mon, 15 Nov 2021 09:41:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/544: Fix inode number ordering code
Message-ID: <20211115174132.GN24282@magnolia>
References: <YZAnUyyKgaddwOQH@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZAnUyyKgaddwOQH@moria.home.lan>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Nov 13, 2021 at 04:00:03PM -0500, Kent Overstreet wrote:
> The code that creates files and moves them to low/high inode number
> files writes different file contents before doing the move - leading to
> non-reproducible results.
> 
> Fix this by writing the file contents after moving them to high/low
> inode number files.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

DOH.  Yep, this is correct.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/544 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/544 b/tests/generic/544
> index 4a9f48526d..4dbaea4de0 100755
> --- a/tests/generic/544
> +++ b/tests/generic/544
> @@ -44,8 +44,9 @@ inum() {
>  # Create two test files, make $low_file the file with the lower inode
>  # number, and make $high_file the file with the higher inode number.
>  create_files() {
> -	_pwrite_byte 0x60 0 $filesize $testdir/file1 >> $seqres.full
> -	_pwrite_byte 0x61 0 $filesize $testdir/file2 >> $seqres.full
> +	touch $testdir/file1
> +	touch $testdir/file2
> +
>  	if [ "$(inum $testdir/file1)" -lt "$(inum $testdir/file2)" ]; then
>  		mv $testdir/file1 $low_file
>  		mv $testdir/file2 $high_file
> @@ -53,6 +54,9 @@ create_files() {
>  		mv $testdir/file2 $low_file
>  		mv $testdir/file1 $high_file
>  	fi
> +
> +	_pwrite_byte 0x60 0 $filesize $low_file >> $seqres.full
> +	_pwrite_byte 0x61 0 $filesize $high_file >> $seqres.full
>  }
>  
>  # Check md5sum of both files, but keep results sorted by inode order
> -- 
> 2.33.1
> 
