Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A543C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 14:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiF2OAp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiF2OAo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 10:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBE022BC1
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656511238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2HMdeTsOpHm9sZRS+HCad5LxmPJ37585281uvtRfvs=;
        b=HzR639FCYFo8Vr79+LEMzuMEMKEZWHfMbmRJGQmTNRTWE/bx7RjrnLOghvlhYGLE3n5qTu
        87ZYny/qnRAWSo7SPyANljUZfcIke0hzvK/1Ru8JSrInrrvfDjNlaJdErY02okwoK0zaca
        1ptfvBmsegy9ErQxZ5EpvCuWMUmC3Yg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-Ia7LOxN7PtuAf0SPepbBtw-1; Wed, 29 Jun 2022 10:00:37 -0400
X-MC-Unique: Ia7LOxN7PtuAf0SPepbBtw-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso16317429qkb.11
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 07:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f2HMdeTsOpHm9sZRS+HCad5LxmPJ37585281uvtRfvs=;
        b=gcpqa0Bik356gkBuhKetofOF+dXOZ/vtk3hHcYCCnp8+sbc7HhOVDsP7rMKPoViNQv
         6wgMkfBdSAkvn7oyTVU7xyNdZA6es9nmQUtWgkmoDkZAPijFPu6yeizkklVRCcmtfAG1
         bxov1EpCIiE4OYna4GSpACmF1/fRtMPpg2GfxZmDPrViG3egwaydQrg0qsHhmCEChMdX
         pKh7rWf5jW4Q+IcjQa6ZJ/6l3PMp1fr4dzAkEgAvIOIzfIFIu3SFxtVXFKszwS4vtsDb
         N5gkZ06ew54uTnT8aVJPHLBgpJOT/kjYPN7IISoaF+8izitRoUlQEr8efBER53GMonU0
         urRA==
X-Gm-Message-State: AJIora/AAgoHJnkuVoGxc6hH/q1VvAYaTqbfEaYdtClmZak1Zm7BCGBn
        huNg0ec4wIdLB2lw7R9qyLhzQ95zMuIUWErkC6u9X1/7q/P8ys3bqrkk3XfC36m52WSi7H8sfRv
        xNN8YibPeE0RBrW/fww==
X-Received: by 2002:ad4:5dcd:0:b0:470:3909:fc4c with SMTP id m13-20020ad45dcd000000b004703909fc4cmr7813770qvh.87.1656511236384;
        Wed, 29 Jun 2022 07:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usOyu3yMvnn48j1MkfYcDc0UP82OtqIkoCk8Oh1Fv3Z1mDYB9br3YBTwqnSGSmp5o3MeyG5A==
X-Received: by 2002:ad4:5dcd:0:b0:470:3909:fc4c with SMTP id m13-20020ad45dcd000000b004703909fc4cmr7813740qvh.87.1656511236032;
        Wed, 29 Jun 2022 07:00:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f30-20020ac840de000000b00315110b47bcsm10853878qtm.22.2022.06.29.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:00:35 -0700 (PDT)
Date:   Wed, 29 Jun 2022 22:00:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs read repair: more tests
Message-ID: <20220629140030.gby6u6gih2dxfs7v@zlang-mailbox>
References: <20220622045844.3219390-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622045844.3219390-1-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 22, 2022 at 06:58:40AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a few more btrfs read repair tests.  Still all for user
> data as I haven't managed to successfully inject corruption into metadata
> yet.

This patchset is good to me (from fstests side). If there's not more review
points or objections from btrfs list, I'll merge it. Welcome more review.

Thanks,
Zorro

> 

