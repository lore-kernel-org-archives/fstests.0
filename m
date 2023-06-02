Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF56C7EE24
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jun 2023 10:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjFBK7R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjFBK7O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Jun 2023 06:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490E137
        for <fstests@vger.kernel.org>; Fri,  2 Jun 2023 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685703506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQ8WMwYvNqYM8vHVJ28mnUUAQ294CKYFZ6ysDtPMKLo=;
        b=SfbfxmHFh+VSGcR7DRelGnBsxeMHSApq3HCImbUonGxHzanhfWqxMx3g8gvgd/WloAoWzH
        1xoEDFq27GR+xSCjDQ9W03EU2ALjekBJu8E16g/PCRPAMEUmixpPXVMAjE+A9QGIC1Vl63
        dsuxezJzNogvN4BP9SMC+IqsQFlVfic=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-6wopXuIoP4SBi0sa1eAmqQ-1; Fri, 02 Jun 2023 06:58:25 -0400
X-MC-Unique: 6wopXuIoP4SBi0sa1eAmqQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25665d2a250so1707362a91.0
        for <fstests@vger.kernel.org>; Fri, 02 Jun 2023 03:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685703504; x=1688295504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ8WMwYvNqYM8vHVJ28mnUUAQ294CKYFZ6ysDtPMKLo=;
        b=kKDqucklB8c1Xkt2SiJi+9nJKoXqLZru0pTRa5/t0jjNOwMJcVH8YVPvV5AclaQnVn
         xypqVUqWE7nteHZop76lUTSOXd+LpL3ZLqDHMd+o0KxIorlb38CMUfO652MAvXhJ6uhQ
         plRHnNa/FAMjbxtsiyCbOZTGDQAYRPFblTutMynd39QKblZ+fV6kLgVKTiDed4kUMle4
         YRKayFVyQqVP6vgenkITUtDSxZjt8bysOZhLbgHVxCFQTfaYEzf3sp0oJXiofvRcX8vD
         mltuiCUz2t5Tz0HRhFkdoVbqpSe6d5+M8ZABHUSLxI0H9opjxf132CgUwtB3FnInEEFp
         UXRg==
X-Gm-Message-State: AC+VfDzlUhq8dpen8d7xhzAWYVRnWCYRVsysqk3lY5f80jfVVy7aYBlb
        NOT4TxHA17/tXF/3uNPzKD151OiMjcZvu4uTIFRXRHwwLHWTuVroaIOTbyMFujY5jc8GcV+rKYY
        v/Y7k3nDjxJiniinQBA==
X-Received: by 2002:a17:90a:6888:b0:255:99bc:9310 with SMTP id a8-20020a17090a688800b0025599bc9310mr1990681pjd.3.1685703504127;
        Fri, 02 Jun 2023 03:58:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xc+Hhm0Mofc9CwinU9dS22wZnbEOEjCGNMkxt5+PE2T5KSTHdXne3yz9LRgciw8cP9aQz4w==
X-Received: by 2002:a17:90a:6888:b0:255:99bc:9310 with SMTP id a8-20020a17090a688800b0025599bc9310mr1990672pjd.3.1685703503864;
        Fri, 02 Jun 2023 03:58:23 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id qe10-20020a17090b4f8a00b0024c1f1cdf98sm2864496pjb.13.2023.06.02.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:58:23 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:58:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230602105819.5jswug337h7mgbmt@zlang-mailbox>
References: <20230601094224.1350253-1-hch@lst.de>
 <20230601094224.1350253-2-hch@lst.de>
 <20230601152536.GA16856@frogsfrogsfrogs>
 <20230601152740.GA31938@lst.de>
 <20230601160450.GB16856@frogsfrogsfrogs>
 <20230602041341.GA19603@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602041341.GA19603@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 02, 2023 at 06:13:41AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 09:04:50AM -0700, Darrick J. Wong wrote:
> > Good question.  AFAICT the only checks on it are in
> > _require_scratch_nocheck itself...
> > 
> > > But yeah, these tests should simply grow a
> > > 
> > > _require_block_device $SCRATCH_DEV
> > 
> > ...but you could set up the scsi_debug device and mount it on
> > $TEST_DIR/foo which would avoid the issue of checking SCRATCH_*
> > entirely.
> 
> I thought about that as we really don't need a SCRATCH_DEV, but
> how do we ensure we are testing a block based file system then?

Maybe

  _require_test
  _require_block_device $TEST_DEV

can help to make sure the FSTYP is a localfs?

Thanks,
Zorro

> 

