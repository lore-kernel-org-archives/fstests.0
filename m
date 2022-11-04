Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D704C433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Nov 2022 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKDSpJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDSpI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Nov 2022 14:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D4812124A
        for <fstests@vger.kernel.org>; Fri,  4 Nov 2022 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667587452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eoDBnX+LNA9mp3n8x9zUfbLp1C0v02eZ8URRGkR8Kxs=;
        b=T9LH5Y3PHtVk0AiGkZQDyr8SjRkPm5W150ugaAab5WoBjlWaGlToyQ89XT7oktGh1de1NR
        71msHNzkw0/jKM6w3/HquzysypFRY3UMu8qmO213709pdFwDD6iA5mh+qkn+D2ud31mg61
        7zUFUCOMehCW4zx/bz0CpW0bCfdyIPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-3Znnx_oUM42pnllfxzjdjw-1; Fri, 04 Nov 2022 14:44:10 -0400
X-MC-Unique: 3Znnx_oUM42pnllfxzjdjw-1
Received: by mail-wm1-f72.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso2686561wms.5
        for <fstests@vger.kernel.org>; Fri, 04 Nov 2022 11:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoDBnX+LNA9mp3n8x9zUfbLp1C0v02eZ8URRGkR8Kxs=;
        b=IIGNllUYdLPR0p6msfHGU5MQG2aaVg3qr0hgS/iQ/TJMkcZ9jmJirwnINtk0a8/+Cy
         eH/c5sRzdOeay4R08sH65RomGcN7tQ0NZLWsAnr3r+o3KDW9og+m+eiaiXufqJwBiPaA
         TvLAd9ifVThZ/DsnQFfVqWfSLaLYoU7Bl96YlkvuodsgDXb52OEhRM1XplL/qi85cShd
         SuXUR4C3eMnVj5DDmsYwiLEBSWCe1VXK86It5V47TUIsR1wCFZWzYR+93cU2ldQEHDKV
         Ta2sIHE1bCRwYAYhj9Yy9lcd3j6irnD1mIcP3J4+O42Ql/b7+cYj+63tQaMhbKQ7queS
         05yA==
X-Gm-Message-State: ACrzQf0vFz0uGce5O18nTbas+EGd3BT9wNiSisfs/1STsJ87J5kthQij
        BJUn+uJgdMkg4Yz6PXylbWpJ23Q1CoYzyldiNeKcZ42hCJDAqQpg4cOOYr3GQwfGAg5r86zamH9
        dBVDrp1ITMSXqftQg
X-Received: by 2002:a5d:674c:0:b0:236:9d0d:8de7 with SMTP id l12-20020a5d674c000000b002369d0d8de7mr23650189wrw.411.1667587449376;
        Fri, 04 Nov 2022 11:44:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7f/uqtFpF/FNtlNdgHfv8+V+OE7j0aUJo2Ml9iuOtXg07lE6BSty0jo7VzjUTfg7a7fOHyAQ==
X-Received: by 2002:a5d:674c:0:b0:236:9d0d:8de7 with SMTP id l12-20020a5d674c000000b002369d0d8de7mr23650180wrw.411.1667587449151;
        Fri, 04 Nov 2022 11:44:09 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id f19-20020adfb613000000b0022dc6e76bbdsm66798wre.46.2022.11.04.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:44:08 -0700 (PDT)
Date:   Fri, 4 Nov 2022 19:44:07 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests PATCH 2/3] generic/577: add missing file removal
 before empty file test
Message-ID: <20221104184407.jpktrea7c4bemhrv@aalbersh.remote.csb>
References: <20221104064742.167326-1-ebiggers@kernel.org>
 <20221104064742.167326-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104064742.167326-3-ebiggers@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 03, 2022 at 11:47:41PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The fix for _fsv_have_hash_algorithm() exposed a bug where one of the
> test cases in generic/577 isn't deleting the file from the previous test
> case before it tries to write to it.  That causes a failure, since due
> to the fix for _fsv_have_hash_algorithm(), the file from the previous
> test case now ends up with verity enabled and therefore cannot be
> written to.  Fix this by deleting the file.
> 
> Reported-by: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/generic/577 | 1 +
>  1 file changed, 1 insertion(+)
> 

Looks good.
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

