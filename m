Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F5EB64D9
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jul 2023 07:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjGFH6k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jul 2023 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGFH6k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2023 03:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637C1BF3
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2023 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688630268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NLwk8FmCnZHmEOoEY/SC3En45441mal0yiuPqiBV2B4=;
        b=L4glH7BTWjDSWREivzkXIWI+gWplK1FFTRJL/wkLuOKRIaHLZLwKCZkAOygCCYtQc04THj
        0Y4BvHSUyk++CTZ8UJFO3hrAS0hlp+FUXWS14hKkdYpVP0YlIPNwFe8PbJb4XKn5EjIVt7
        kZJbhAx9CeAFQ5KiQWuEuewe0dVJ4ag=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-kGv01oomMVa8tPZCyAJ7BA-1; Thu, 06 Jul 2023 03:57:46 -0400
X-MC-Unique: kGv01oomMVa8tPZCyAJ7BA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b8902f02a1so2845655ad.2
        for <fstests@vger.kernel.org>; Thu, 06 Jul 2023 00:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630265; x=1691222265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLwk8FmCnZHmEOoEY/SC3En45441mal0yiuPqiBV2B4=;
        b=Tfo3HmVuUeZEmdqvF8+8Ar6YurxvLWYZs4dPWvL77M8Rm/vRH//xjc75+LJkrf+7/m
         qR44dojEH2EOhLmjxTqfaH+bee8vBWR1GfoW1vqGlJfTe9JEZ3YNt5nON09N/PWe7xc+
         VLapJFR/2B2mNGyolf4q1aeSVd0wbA0IYN5Eqp/bgOTEJiIUzTAgmywC8vNkhq1lnJwm
         Joh1WjhzbJcr3zx3f95kQyyP03VLAhlRvLBtw+23fkqacp/iQm7xUeAjlke6dTWbbjOV
         +ndxr/G4IRzsNL/EiGEloQO0Obm0HTkhUoauvLa8ixxKMvSqSk5+7cnPSRHgbncHsBf5
         EBSQ==
X-Gm-Message-State: ABy/qLY8hGIwNGznApN1eK2BdxDpFc/Em6m0y0oHhEOMz6kSMLBx+U/0
        mn8ugVXwCFXu4Eoe0q9Qs8G1GrT6zivecb4WEj6ilkPsGZ1Uj/Np0Qvs01mlZd7UdK3zLByl3v0
        Kn7Bw/HsFgAUr2YUZog==
X-Received: by 2002:a17:903:1205:b0:1b3:b998:8007 with SMTP id l5-20020a170903120500b001b3b9988007mr1024649plh.55.1688630265577;
        Thu, 06 Jul 2023 00:57:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqjJPoZAQR9iKS0/kLVEB7SiO22isSKxIg4Dtf0TyIX81w89icjxXVU1SCZ/K1+Fht+DxzGA==
X-Received: by 2002:a17:903:1205:b0:1b3:b998:8007 with SMTP id l5-20020a170903120500b001b3b9988007mr1024636plh.55.1688630265282;
        Thu, 06 Jul 2023 00:57:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001b843593e46sm755483plk.73.2023.07.06.00.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:57:44 -0700 (PDT)
Date:   Thu, 6 Jul 2023 15:57:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1.1 3/5] xfs/439: amend test to work with new log
 geometry validation
Message-ID: <20230706075741.vsghan7ywoj5h4wz@zlang-mailbox>
References: <168840381298.1317961.1436890061506567407.stgit@frogsfrogsfrogs>
 <168840383001.1317961.12926483978316384291.stgit@frogsfrogsfrogs>
 <20230705153819.GS11441@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705153819.GS11441@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 05, 2023 at 08:38:19AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> An upcoming patch moves more log validation checks to the superblock
> verifier, so update this test as needed.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v2: annotate which commits this tests is testing
> ---
>  tests/xfs/439 |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/439 b/tests/xfs/439
> index b7929493d1..cb6fb37918 100755
> --- a/tests/xfs/439
> +++ b/tests/xfs/439
> @@ -20,8 +20,14 @@ _begin_fstest auto quick fuzzers log
>  # real QA test starts here
>  _supported_fs xfs
>  _require_scratch_nocheck
> -# We corrupt XFS on purpose, and check if assert failures would crash system.
> -_require_no_xfs_bug_on_assert
> +
> +# We corrupt XFS on purpose, and check if assert failures would crash the
> +# system when trying to xfs_log_mount.  Hence this is a regression test for:
> +_fixed_by_git_commit kernel 9c92ee208b1f "xfs: validate sb_logsunit is a multiple of the fs blocksize"
> +
> +# This used to be _require_no_xfs_bug_on_assert, but now we've fixed the sb
> +# verifier to reject this before xfs_log_mount gets to it:
> +_fixed_by_git_commit kernel f1e1765aad7d "xfs: journal geometry is not properly bounds checked"

Thanks, I'll replace "_fixed_by_git_commit kernel" with "_fixed_by_kernel_commit"
when I merge this patch. Others looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  rm -f "$seqres.full"
>  
> @@ -33,7 +39,7 @@ blksz=$(_scratch_xfs_get_sb_field blocksize)
>  _scratch_xfs_set_sb_field logsunit $((blksz - 1)) >> $seqres.full 2>&1
>  
>  # Check if logsunit is set correctly
> -lsunit=$(_scratch_xfs_get_sb_field logsunit)
> +lsunit=$(_scratch_xfs_get_sb_field logsunit 2>/dev/null)
>  [ $lsunit -ne $((blksz - 1)) ] && _notrun "failed to set sb_logsunit"
>  
>  # Mount and writing log may trigger a crash on buggy kernel
> 

