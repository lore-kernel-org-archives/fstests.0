Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CFC0015E
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Aug 2023 13:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHENws (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Aug 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHENws (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Aug 2023 09:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9E10C6
        for <fstests@vger.kernel.org>; Sat,  5 Aug 2023 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691243515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E97UB8xbtwjBZ/700mdBa45izV7GQAIkEwB+bI/3Wb0=;
        b=B/Vp6uCn3g/OBYpeqqsLoLSOep5daQjYIZNKsf9KivvEgeoM1jyjTFUz/yrkemR2sd2oVC
        l5JSD4kqV42UOjJj2hMKpDc93JGwFDkiB8Re3uRaJk/X7nJWjc+V5s8Lgli4CTqxzNLXoW
        qHGZTYSxX6FusiHwfEGGVQXnKkTSffg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Oa4fpJ0kO3m9Tdw-2cWB5A-1; Sat, 05 Aug 2023 09:51:54 -0400
X-MC-Unique: Oa4fpJ0kO3m9Tdw-2cWB5A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5646e695ec1so2805061a12.1
        for <fstests@vger.kernel.org>; Sat, 05 Aug 2023 06:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691243513; x=1691848313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E97UB8xbtwjBZ/700mdBa45izV7GQAIkEwB+bI/3Wb0=;
        b=I1KcS9VfAkMuIhm1OXxIMsHvhnWlgflrNndk20xfXbJmEfwtCzydwXV6jN/aJXAUwO
         BEeOzQTkRfGrdUSj7lgENA7fEUAFq+9uzrY01KCH1VY5zSVCXheYwwHv/7sEOUbTfgYy
         w9fD0XR2TSo0UzXUSNU7aMtY9B0LjGxWPy6eebZzTuhQQfc776nuX2l1FE8UFhjtxBRH
         mXnMarLemlgWerOBUqQeKF5O2KIYoIG/PEsHdMvYOaKqGvUI1CR/6XELrS7j9ub7neYU
         5+HYcbItJGBfniz4JxlHbXScSnttwuxyPBr8o6qP5Pa2R0CPVZxMGaXrkbFd4terd7/K
         DryQ==
X-Gm-Message-State: AOJu0YzbHFwV0NcaVM7agoQeT7zhPrPGIJdXQzUVotmgIJb/cuy88pLR
        rwIPvhmFHU4mTXIWUnoKZl4RV6hFf6QGtnxkfkzRS5HR41388wtuOj6mFsKgeE5DiRYljCeBK9Z
        eJTKLtpWaVrFayK2oDA4/L8q1QFu3u2U=
X-Received: by 2002:a05:6a21:1f25:b0:11c:fc27:cda4 with SMTP id ry37-20020a056a211f2500b0011cfc27cda4mr4373065pzb.11.1691243512951;
        Sat, 05 Aug 2023 06:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIgdN4FmyGZUI8Zo+TGqqCvqPGEnD+0QM/K2vkOXJiB8PLuymuquuDdeeliCO6s9X6SMcXoQ==
X-Received: by 2002:a05:6a21:1f25:b0:11c:fc27:cda4 with SMTP id ry37-20020a056a211f2500b0011cfc27cda4mr4373056pzb.11.1691243512585;
        Sat, 05 Aug 2023 06:51:52 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b00679a4b56e41sm3182616pfh.43.2023.08.05.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 06:51:52 -0700 (PDT)
Date:   Sat, 5 Aug 2023 21:51:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: skip fragmentation tests when alwayscow mode is
 enabled, part 2
Message-ID: <20230805135148.rbk7uo7ldsxj7e56@zlang-mailbox>
References: <20230804213419.GO11340@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804213419.GO11340@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 04, 2023 at 02:34:19PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If the always_cow debugging flag is enabled, all file writes turn into
> copy writes.  This dramatically ramps up fragmentation in the filesystem
> (intentionally!) so there's no point in complaining about fragmentation.
> 
> I missed these two in the original commit because readahead for md5sum
> would create large folios at the start of the file.  This resulted in
> the fdatatasync after the random writes issuing writeback for the whole
> large folio, which reduced file fragmentation to the point where this
> test started passing.
> 
> With Ritesh's patchset implementing sub-folio dirty tracking, this test
> goes back to failing due to high fragmentation (as it did before large
> folios) so we need to mask these off too.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me, this patch is simple enough and no risk, will be inserted into
the release directly tomorrow.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/180 |    1 +
>  tests/xfs/208 |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/xfs/180 b/tests/xfs/180
> index cfea2020ce..d2fac03a9e 100755
> --- a/tests/xfs/180
> +++ b/tests/xfs/180
> @@ -23,6 +23,7 @@ _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fiemap"
>  _require_xfs_io_command "cowextsize"
> +_require_no_xfs_always_cow
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> diff --git a/tests/xfs/208 b/tests/xfs/208
> index 9a71b74f6f..1e7734b822 100755
> --- a/tests/xfs/208
> +++ b/tests/xfs/208
> @@ -26,6 +26,7 @@ _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fiemap"
>  _require_xfs_io_command "cowextsize"
> +_require_no_xfs_always_cow
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> 

