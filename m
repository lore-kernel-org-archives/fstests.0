Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65928C001B0
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Jul 2023 06:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGEGiE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjGEGiC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jul 2023 02:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF710FA
        for <fstests@vger.kernel.org>; Tue,  4 Jul 2023 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688539036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NUWX5UvhowWYsdPQKhRlSWjHJ9IgFtq6PuCnNgnxE/c=;
        b=cIlv3FgXK1ulMblPaBCA4gq7SC50ubNe0RiqMOPhzKtCUhCluZQyETb9+LZtoTB+o39mna
        fnqJbtPibNHBVJAfPH3MHYCqwoiSX8euLutLBqu3YRNABdy3bLX7jD6lD59GjlxZ+e6Qvq
        q/ZHtcdMYFSIkbxNSjsk4/GN1UyOOHc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-mqJ5u4mqNq6YpOd7ZOUuVQ-1; Wed, 05 Jul 2023 02:37:15 -0400
X-MC-Unique: mqJ5u4mqNq6YpOd7ZOUuVQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-553d076dce5so5675351a12.3
        for <fstests@vger.kernel.org>; Tue, 04 Jul 2023 23:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539034; x=1691131034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUWX5UvhowWYsdPQKhRlSWjHJ9IgFtq6PuCnNgnxE/c=;
        b=YPG2hMK51Ub5kzxwEkuCKQbK7XpNxE3AxpUL0CbvGrZryufWs6Bk29CWyoSiIbxsb+
         /Pxv0+wX/bhehAfnYoJOSeGjFXg/FM+4JI+zRJlGVFqEk6ktcE944qntes9Nlvnn56JJ
         FiQ5/M7jbsJ0ivX4cHB+ZjZkxInl+jh47bRN+gIyNmXr0eIqUD5etcbi1gSb8JxaO9ol
         BkIoqI10ILJVxIe7+jE0Ll7qpe3dnPPVvuJOX//zoQkjkEo+/I5yA7I1WoEUi4afkBTt
         SiZDkwreNooDpxY1Toe0Ck5DO2wYWTS83HGdqCZwqoYVHMccNKtftbiuny3LpUPGhWvn
         0n7g==
X-Gm-Message-State: ABy/qLY5TMis3UEhRiETuGrdCNReWvso5Cuvhf4dsx1F6kryscjt0lc0
        VAZx7j+slyzr5C2PGiuFsqo58KQ+Nd9rbCICulvQTOTXFYC+xmlMNSMKmXJ1AOGRdzTb+sDkuDc
        IGfUQB/oQ/DQgZYQGxlIrDOwXyPR/q84=
X-Received: by 2002:a05:6a20:3955:b0:11f:b885:e83a with SMTP id r21-20020a056a20395500b0011fb885e83amr14819064pzg.57.1688539033981;
        Tue, 04 Jul 2023 23:37:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHtcHVO2xFemkdavNw1sqIuI05mR6jkvj+chy+9Ote8/pYCCNbPd+dkvSc7hMq1p/UWQ7RhJw==
X-Received: by 2002:a05:6a20:3955:b0:11f:b885:e83a with SMTP id r21-20020a056a20395500b0011fb885e83amr14819055pzg.57.1688539033672;
        Tue, 04 Jul 2023 23:37:13 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001b694140d96sm9233434pli.170.2023.07.04.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:37:13 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:37:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] xfs/439: amend test to work with new log geometry
 validation
Message-ID: <20230705063709.4grbfaznsddnxf4c@zlang-mailbox>
References: <168840381298.1317961.1436890061506567407.stgit@frogsfrogsfrogs>
 <168840383001.1317961.12926483978316384291.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168840383001.1317961.12926483978316384291.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 03, 2023 at 10:03:50AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> An upcoming patch moves more log validation checks to the superblock
> verifier, so update this test as needed.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/439 |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/tests/xfs/439 b/tests/xfs/439
> index b7929493d1..8c69ece655 100755
> --- a/tests/xfs/439
> +++ b/tests/xfs/439
> @@ -21,7 +21,9 @@ _begin_fstest auto quick fuzzers log
>  _supported_fs xfs
>  _require_scratch_nocheck
>  # We corrupt XFS on purpose, and check if assert failures would crash system.
> -_require_no_xfs_bug_on_assert
> +# This used to be _require_no_xfs_bug_on_assert, but now we've fixed the sb
> +# verifier to reject this before xfs_log_mount gets to it:
> +_fixed_by_kernel_commit XXXXXXXXXXXX "xfs: journal geometry is not properly bounds checked"

This case is a regression test case for:
  9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")

So I think it's better to write this major commit at first, before recording the
secondary one.

>  
>  rm -f "$seqres.full"
>  
> @@ -33,7 +35,7 @@ blksz=$(_scratch_xfs_get_sb_field blocksize)
>  _scratch_xfs_set_sb_field logsunit $((blksz - 1)) >> $seqres.full 2>&1
>  
>  # Check if logsunit is set correctly
> -lsunit=$(_scratch_xfs_get_sb_field logsunit)
> +lsunit=$(_scratch_xfs_get_sb_field logsunit 2>/dev/null)

What kind of error should be ignored at here?

>  [ $lsunit -ne $((blksz - 1)) ] && _notrun "failed to set sb_logsunit"
>  
>  # Mount and writing log may trigger a crash on buggy kernel
> 

