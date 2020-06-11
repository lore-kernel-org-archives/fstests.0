Return-Path: <SRS0=h6Hu=7Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433BC433E1
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C0F2075F
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 04:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBVF+bg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgFKEv7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:51:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbgFKEv7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jun 2020 00:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591851117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pvyr7sajDt3PerA3UQ0VglmpF/jaw3iEv0C/FEEuwmw=;
        b=HBVF+bg2mvYPTENCBKo0ZKOsnYcWkJWhcQWsRYnUc4rzZmkbhSo1/RgpkWqOU3donV07bJ
        VclHzSg2Vk5UWRKS8QvFJBZTjHIOFJwkHWsdAR/A1ZsBJPoszVLmplNPhoGCHkV2gWeIVD
        ZvV8Q3B+Oj3Akktcg4P3f2WyPxkBL4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-dWnslBDfMPisO5vGWM1ALQ-1; Thu, 11 Jun 2020 00:51:53 -0400
X-MC-Unique: dWnslBDfMPisO5vGWM1ALQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D738E800053;
        Thu, 11 Jun 2020 04:51:52 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52C358FF7C;
        Thu, 11 Jun 2020 04:51:52 +0000 (UTC)
Date:   Thu, 11 Jun 2020 13:03:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Donald Douwsma <ddouwsma@redhat.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfstests: add test for xfs_repair progress reporting
Message-ID: <20200611050345.GL1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Donald Douwsma <ddouwsma@redhat.com>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200519160125.GB17621@magnolia>
 <20200520035258.298516-1-ddouwsma@redhat.com>
 <20200529080640.GH1938@dhcp-12-102.nay.redhat.com>
 <3097a996-c661-d03f-a3e6-aa60ea808f04@redhat.com>
 <41124f57-55e6-68c4-ef90-b51fc5e3b68f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41124f57-55e6-68c4-ef90-b51fc5e3b68f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 01, 2020 at 01:55:49PM +1000, Donald Douwsma wrote:
> 
> 
> On 01/06/2020 10:53, Donald Douwsma wrote:
> > Hi Zorro,
> > 
> > On 29/05/2020 18:06, Zorro Lang wrote:
> >> On Wed, May 20, 2020 at 01:52:58PM +1000, Donald Douwsma wrote:
> 
> <snip>
> 
> >>> --- a/tests/xfs/group
> >>> +++ b/tests/xfs/group
> >>> @@ -513,3 +513,4 @@
> >>>  513 auto mount
> >>>  514 auto quick db
> >>>  515 auto quick quota
> >>> +516 repair
> >>
> >> Is there a reason why this case shouldn't be in auto group?
> >>
> >> Thanks,
> >> Zorro
> > 
> > 
> > We could work to wards getting it into auto, I wanted to make sure it
> > was working ok first.

I just rechecked the mail list, sorry I missed this email long time (CC me will
make sure I won't miss it next time:)

I think several minutes running time is acceptable to be into auto group, if the
case is stable enough, won't fail unexpected.

> > 
> > It takes about 2.5 min to run with the current image used by
> > _scratch_populate_cached, by its nature it needs time for the progress
> > code to fire, but that may be ok.
> > 
> > It sometimes leaves the delay-test active, I think because I've I used
> > _dmsetup_remove in _cleanup instead of _cleanup_delay because the later
> > unmounts the filesystem, which this test doesnt do, but I'd have to look
> > into this more so it plays well with other tests like the original
> > dmdelay unmount test 311.
> 
> Actually it does clean up delay-test correctly (*cough* I may have been
> backgrounding xfs_repair in my xfstests tree while testing something
> else).  I have seen it leave delay-test around if terminated with 
> ctrl+c, but that seems reasonable if a test is aborted. 

If use a common helper to DO a test, I'd like to use its corresponding
helper to cleanup UNDO it. If there's still something wrong, we can fix the
helpers.

> 
> > I wasn't completely happy with the filter, it only checks that any of the
> > progress messages are printing at least once, which for most can still
> > just match on the end of phase printing, which always worked. Ideally it
> > would check that some of these messages print multiple times.
> > 
> > I can work on a V3 if this hasn't merged yet, or a follow up after, thoughts?

Sure, hope the V3 can improve the output mismatch issue, although the filter is
really boring:)

Thanks,
Zorro

> > 
> 
> 

