Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47804C433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 07:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446026AbiEGIAX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 04:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446041AbiEGIAW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 04:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C02B4EDFB
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651910195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZeOpQWsoHl6EBlLAbOtSMSXhDpRoZDlH+ZP0O5SyBc=;
        b=BjuHRnPBLJmJ15n0hG4uXj2MLMrahlHp8K4vhEV1218jXaNSwkqrQV/Ya16cnV02lD6v6V
        xcXfX9AJAYGAkW9YzBqoQBO+swMoubl77FqPJ69ijf1Y4wJL9AoHZoMzyxn/JMeYsxJmbY
        lFcRIkpIVUDKYTnrMcd9R9q7A+3TI2k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-KmYQDmavP9eTLFIYkp3kHA-1; Sat, 07 May 2022 03:56:34 -0400
X-MC-Unique: KmYQDmavP9eTLFIYkp3kHA-1
Received: by mail-lf1-f69.google.com with SMTP id l19-20020ac24313000000b004739dbba717so4182948lfh.5
        for <fstests@vger.kernel.org>; Sat, 07 May 2022 00:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mZeOpQWsoHl6EBlLAbOtSMSXhDpRoZDlH+ZP0O5SyBc=;
        b=WS3VbV7X+5uhmUW7x8RL2Ub9nlgnhRK164gWdpTeNS1sxGLYsbF9c6TMV+evC3p6fD
         nAlKNhbxlynHDVImFHpBPGz2vHG0zzczbwCRSYr7GeIpDmXqcT11ZHqVrzdOGS7cOAyo
         l/RKHuPAfAkSzEERWaQaNVN4Kf8A8noIG7mcM59kC8KfS4uumPGvRaVPjB7mChVQQbG0
         lfkfMZ/9DZm7GPBSYs5eQrmdCqR4MhJHOwlX9w/oyQajLM9Wv3twa1yVUdW7q8jUow3M
         7oWXMFcxPhatyVLRe7/87gqx9RVvAhz32xcVobK667+GLDvMBp8WJZag6DspEGZLX92F
         e/2g==
X-Gm-Message-State: AOAM533aPpc6Hu3Op7jiZTfKHDFiWJJbDa8P4NCkazOXKq9Xv2mkz4D+
        hhjaktUtfjLCtOWXJGxF3yV0MzSIRTugytxY4Gm4yE4tSMeA5++TayiTN8fOfNI7JtLFKYJ6GcU
        UCAs9GN7CQ0Tf0B/ssV3dWEl+jj9JpxTfKg==
X-Received: by 2002:a05:6512:c28:b0:473:b6ce:96fe with SMTP id z40-20020a0565120c2800b00473b6ce96femr5221913lfu.595.1651910192372;
        Sat, 07 May 2022 00:56:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm0VZA0zlIz6xGUPwpsUmwLcflbRq49YXMWx5gF+hPueKakpbH65AtQrxf8tPTPeQrH5EDg2ABPb2S+Zj+b6g=
X-Received: by 2002:a05:6512:c28:b0:473:b6ce:96fe with SMTP id
 z40-20020a0565120c2800b00473b6ce96femr5221901lfu.595.1651910192164; Sat, 07
 May 2022 00:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220506150141.333929-1-ridave@redhat.com> <20220507072952.dmtr3chfeofthorx@zlang-mailbox>
In-Reply-To: <20220507072952.dmtr3chfeofthorx@zlang-mailbox>
From:   Rishabh Dave <ridave@redhat.com>
Date:   Sat, 7 May 2022 13:26:20 +0530
Message-ID: <CA+jMu4SNSPtSPyZ+Hv5nC_sJhptj=iM6z4_3C3EZ2FzhTjDOSg@mail.gmail.com>
Subject: Re: [PATCHv2] cephfs: add ceph-fuse suport for ceph-fuse
To:     Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Rishabh Dave <rishabhddave@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, 7 May 2022 at 13:00, Zorro Lang <zlang@redhat.com> wrote:
>
> This patch has been merged, refer to 1dac95cb ("cephfs: add ceph-fuse suport
> for ceph-fuse") in fstests for-next branch. And I've helped to fix that ";;"
> missing problem.
>
> The release [ANNOUNCE] is:
> https://lore.kernel.org/fstests/20220430190921.7BC56C385A7@smtp.kernel.org/
>
> If you need to fix more issues, please write new patch base on the latest
> fstests for-next branch.
>

Okay. Thanks for the fix and thanks for the merge.

Is merging in the for-next branch as good as merging in the master? Or
should I watch out for my commit until it merges in master?

