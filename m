Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87318C7EE2E
	for <linux-fstests@archiver.kernel.org>; Sat, 10 Jun 2023 06:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFJGrR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 10 Jun 2023 02:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjFJGrQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 10 Jun 2023 02:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8193A94
        for <fstests@vger.kernel.org>; Fri,  9 Jun 2023 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686379587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4sla1+vq3LKjf/7Puqr2iWfI5n8hHXjwWv5kUu83RQ=;
        b=V60w/B2syBGXBkpSpoNE84/t68XFl7wdS7zQ9lSwd0vkTuvSlKJPFAkErAfuhxw+BcDlfp
        MA1rWfwFE0bDgEytIaUe/KQoSI9KcNtOB0OTV+CH/OrPXkYKIANluYmt1RNAO9mP0DUaO+
        xgaAOTujrTKrUvIR/TnUuidswM+aqM4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-rQaT1_XnMpysc3v0VHho9g-1; Sat, 10 Jun 2023 02:46:25 -0400
X-MC-Unique: rQaT1_XnMpysc3v0VHho9g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2568caac092so895941a91.1
        for <fstests@vger.kernel.org>; Fri, 09 Jun 2023 23:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686379584; x=1688971584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4sla1+vq3LKjf/7Puqr2iWfI5n8hHXjwWv5kUu83RQ=;
        b=cXkzfsJD1UVcQzqgvr/Ui2ZGQnhk001ywl+bL0GbQhgtW+WXpE5gi3TJKzcvVFZEFd
         wwtobpWnUMgquYjLAbXTvS2h7LbdxSobqnW1V8ZxZupKUdcJ1w5iV1rHOEAVPd0nbbYE
         pPSRFmuwykXXDh50VcteTIwhUFBCEqH262BVwPQnj2Ao0gMTfSebvdKpYbvXEiAoDZJc
         vMLS7UUIYGDcnuKpRWjIi/IWrV4gYKvkIDKbzuX/5OWd5UcQPUgp0uQnd8NLYJO4Kg6h
         12Xf1lRHLOPvasTq10REpjuec8ExgwqhHAPMptLY0C8eTFQVCkcuxaVU4myWxweKTt26
         5FQA==
X-Gm-Message-State: AC+VfDyrIbJ0n5zZKSocNPH4XkKjcNdYgUkFz0ojMJIPkmsWIlUKxcIS
        dQ/4VC76XDC3UjF6/1jhcS1m/6GyDsUJ4z37uq/77szUnAJb181kyrqEB8NF7PAdTw8cCnD0Zx7
        2aUVLDSvA7VUvokZxRg==
X-Received: by 2002:a17:90a:c710:b0:24c:df8:8efa with SMTP id o16-20020a17090ac71000b0024c0df88efamr2726485pjt.39.1686379584534;
        Fri, 09 Jun 2023 23:46:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xct6zxTa41x7guIOarBEs0IXVU5MfJ+TvgwlkX6DQJrrYPQHPLvS/Gtlgmarw95T3VFtrrw==
X-Received: by 2002:a17:90a:c710:b0:24c:df8:8efa with SMTP id o16-20020a17090ac71000b0024c0df88efamr2726477pjt.39.1686379584257;
        Fri, 09 Jun 2023 23:46:24 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a190e00b00259b729eea9sm4110760pjg.8.2023.06.09.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 23:46:23 -0700 (PDT)
Date:   Sat, 10 Jun 2023 14:46:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
Message-ID: <20230610064620.4ovt52l4lcvrijyn@zlang-mailbox>
References: <20230608114836.97523-1-wqu@suse.com>
 <ZIHGb+KyYW72MVzp@infradead.org>
 <5790cd5a-04d9-bfe9-a8cc-0c09f784222d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5790cd5a-04d9-bfe9-a8cc-0c09f784222d@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 09, 2023 at 07:57:37AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/8 20:15, Christoph Hellwig wrote:
> > On Thu, Jun 08, 2023 at 07:48:36PM +0800, Qu Wenruo wrote:
> > >   	echo 3 > /proc/sys/vm/drop_caches
> > > +	# Above drop_caches doesn't seem to drop every pages on aarch64 with
> > > +	# 64K page size.
> > > +	# So here as a workaround, cycle mount the SCRATCH_MNT to ensure
> > > +	# the cache are dropped.
> > > +	_scratch_cycle_mount
> > 
> > The _scratch_cycle_mount looks ok to me, but if we do that, there is
> > really no point in doing the drop_caches as well.
> 
> Yep, we can remove that line. It's mostly a reminder for me to dig out why
> that drop_caches doesn't work as expected.

How about leaving a reminder/explanation in comment, remove that real drop_caches
line. If no objection, I'll merge this patch with this change.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 

