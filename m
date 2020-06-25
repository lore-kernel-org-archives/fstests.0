Return-Path: <SRS0=7+VG=AG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38808C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Jun 2020 03:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7762078D
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Jun 2020 03:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICTnH8AA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbgFYDPc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Jun 2020 23:15:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55952 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389549AbgFYDPc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Jun 2020 23:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593054930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GR1AojJY93YrdgWF2iqnj9nZCFRfmrnPMvgPHMlgI+o=;
        b=ICTnH8AAZNIUgwPhg7DwapcGMP2TQj77sTo+DZYI2T5nnw/zA6aOaI++IAtq2wsfQBzY3O
        rqP4YEmqaB81QjX+0X/TUbEj/HppPEF0xSCfAzpV2y+CJwFjFTpRZQtB7NFuDu7tniG067
        Mr4aV9kirB1drBPp45aHD3BfuRdjNNM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-p5_Z0-jlNkOMKt-Kw1mcog-1; Wed, 24 Jun 2020 23:15:28 -0400
X-MC-Unique: p5_Z0-jlNkOMKt-Kw1mcog-1
Received: by mail-pl1-f199.google.com with SMTP id 59so2842231pla.12
        for <fstests@vger.kernel.org>; Wed, 24 Jun 2020 20:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GR1AojJY93YrdgWF2iqnj9nZCFRfmrnPMvgPHMlgI+o=;
        b=aIEb1nJW6DC+kgivd7y8Qd52iLu6eRTGOyQF9Kd3jFuiMrTTDfufwx69B4TDPrwhgv
         mrYFYi/s8ULt5lwuYkhCr4dlO/Ts/LfLpC+VR1cg+KB0wkVA6WlwOgGDdGs1v8MX/E+g
         X76yko0Z4kKO0qdkHwTqalPYgdpHnU2T0H/8h6H0OMwMAphPDuF8+4tCq3S52HO8YhgE
         7riruLSeirGi65Mj23cfOHzttFqRErz6oGs2W9MbKC9ksl0nwkN5wHzXrXOTY7tDSQGF
         iNB2j7Zzvo/UykjqiKlratP4ikJu4j9MRnK6SF/wXt2/z+yX9awhJYJRu9JtcIrhQpYa
         SFnw==
X-Gm-Message-State: AOAM532lLTfs1H3CW+m8CSWd91GlGsLPzsSmwIZNVx6vA+JpvaddlT28
        ICfVv2HoDQW0KbcNxxvINmq6sO/4AvOUixP0j8LbsJNAbgGwLef4gjfRG7hAGa4oQT4VLZ7d6Kp
        hR9eEuqvxVN+6AOSZ6w==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr1011796pjb.65.1593054927380;
        Wed, 24 Jun 2020 20:15:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHdwk68885TNxir9aIGHQ9L7zaKSC7ZuMls9K113XJNw9JQKr3pHqFiVxbT/5GLUck06+OJQ==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr1011782pjb.65.1593054927179;
        Wed, 24 Jun 2020 20:15:27 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b19sm20754636pft.74.2020.06.24.20.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 20:15:26 -0700 (PDT)
Date:   Thu, 25 Jun 2020 11:15:17 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v3] xfs: add test for CVE-2020-12655
Message-ID: <20200625031517.GB6242@xiangao.remote.csb>
References: <20200623020447.5924-1-hsiangkao@redhat.com>
 <20200624010630.4728-1-hsiangkao@redhat.com>
 <20200624151851.GI7625@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624151851.GI7625@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 24, 2020 at 08:18:54AM -0700, Darrick J. Wong wrote:

...

> > +			$seqres.full 2>&1
> 
> Just FYI we conventionally use:
> 
> $XFS_IO_PROG -f -c 'pwrite 0 64k' $SCRATCH_MNT/test >> $seqres.full
> 
> to create files in fstests with less typing, but no need to reroll this
> whole thing just for that.

Okay, hope Eryu could update this when applying.
(anyway I could resend quickly if needed...)

Thanks,
Gao Xiang

