Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727BC77B7C
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbjDZOyf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbjDZOye (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAD30FC
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682520827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKUZG90sruXO+6tDlYwywO6OvoQ7HS0yv2ew14dMeeY=;
        b=bmd/ObqgRCrthahOf5VJB8Wb5ggIs4kHmBac01F6C8QNyXRuF7G3SMeU5YT/FJ5kLbTFhA
        ncvvCom0Ljhf3Pkc9HTeC8f4qL7pKXcDmHqg/6Hc4rQvh6YMBgYCymDa9LTO3/6odHZWfb
        AuBiHy986FxJ+az2+4JnQS/iWusE+Uw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-dD5RkxG8P0OGHH_p3k9NEA-1; Wed, 26 Apr 2023 10:53:46 -0400
X-MC-Unique: dD5RkxG8P0OGHH_p3k9NEA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63f17b06d3fso4262384b3a.1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520825; x=1685112825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKUZG90sruXO+6tDlYwywO6OvoQ7HS0yv2ew14dMeeY=;
        b=K7aXuKXJCl4eRWO5k/PkqsDjHmJAOeNy5XXK0w+qPTZvlsNv1Z2tGS9jVOwV4VeFbB
         vSkI2Rxs68x/xRjVYca7OfKp8ye3B9LlH7oBUW4TOpOHANRH9SJhsUAaioRKJI189kkq
         6RceU8lJ1E42o2zvh+0K0RvDZuJjsAWTLcemiFwIjjCSseEAAf/A0TF0YqeHaoZm+43O
         LeLn/8tx4FfYlncJW8+ooMycO/hW1KIyB7W4cy5VEf2hQCLN5RBcZka7oYQyFMdwR/Wg
         zc0OKE0ETisVG7Gcmdq4c8/JPq28a4Q2kzTCjtIZcH5mRO8H6ce1/p2h1UUqhXgSB4Nb
         6JTA==
X-Gm-Message-State: AAQBX9dEJdB67Vfh1wceZ/PDA80oRW3cnvw+1x+JXQrq1H7GZFEOZRW7
        huYtWnC0h4uWttQNIKTqSI9XCEzWNNYKmtmy8l1wahph9h3Pd7byV3LhLRZf/+J0iDOe1vUWEBx
        zWAMcEbguDDupT6aiBw==
X-Received: by 2002:a05:6a20:8e2a:b0:f2:bbf:f5f4 with SMTP id y42-20020a056a208e2a00b000f20bbff5f4mr25597588pzj.52.1682520825116;
        Wed, 26 Apr 2023 07:53:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZfJdTP74S0tivT3VQZSBljWwLwyQX/64aJEW90aeZR+wmMJ+8GW7u6RI2EvrXZxghc6pDTwg==
X-Received: by 2002:a05:6a20:8e2a:b0:f2:bbf:f5f4 with SMTP id y42-20020a056a208e2a00b000f20bbff5f4mr25597563pzj.52.1682520824806;
        Wed, 26 Apr 2023 07:53:44 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t23-20020a6564d7000000b00524dde7231dsm7916164pgv.9.2023.04.26.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:53:44 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:53:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 6/6] generic/696: AFS doesn't support the "noacl"
 command line option
Message-ID: <20230426145339.ppjespiy7zqmjbqm@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141042.450535-7-dhowells@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 03:10:42PM +0100, David Howells wrote:
> AFS doesn't support the "noacl" command line option.  ACLs are mandatory
> and interpreted by the server.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
>  tests/generic/696 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/696 b/tests/generic/696
> index 178d78e1..55a2fd5a 100755
> --- a/tests/generic/696
> +++ b/tests/generic/696
> @@ -31,7 +31,10 @@ _scratch_mkfs >$seqres.full 2>&1
>  $here/src/vfs/vfstest --test-setgid-create-umask \
>          --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
>  
> -export MOUNT_OPTIONS="-o noacl $MOUNT_OPTIONS"
> +if [ "$FSTYP" != afs ]
> +then
> +    export MOUNT_OPTIONS="-o noacl $MOUNT_OPTIONS"
> +fi

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  # Also test S_ISGID stripping whether works correctly on underflying filesystem
>  # that supports noacl feature.
> 

