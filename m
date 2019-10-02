Return-Path: <SRS0=G1tu=X3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB46ECE587
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3CC20842
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 00:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569977363;
	bh=wRRq3OMuH+EYhScT4N/jZoemae8Y/42c1CAVXf3riVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YTZ+JjsAN6ac726aN7i2YmTdDZTNblmpHmHlx9/0HugIz0nhALOwA8T4tVHkA/rAG
	 6GIJewfePMM/MzAmhqulCJmmgrzfg2p3Hx77sm6bS9Oyd+4A4PmwNawh8g2iV5sG9p
	 qG4oWrHQMI7c1pqhWFrUTlvhEX3AzdYKLBmLb6Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJBAtW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfJBAtW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Oct 2019 20:49:22 -0400
Received: from localhost (unknown [148.87.23.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF70E2070B;
        Wed,  2 Oct 2019 00:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569977361;
        bh=wRRq3OMuH+EYhScT4N/jZoemae8Y/42c1CAVXf3riVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeT0GinuOx6MqQrLAHQYMNO/x0Z+20NpdsamrVyGEFmH67eNKlP3AiP1cBN5oiBG5
         dEG3UU7Bw9rBGzUnrSOv+adwrn0VRK9XjjHd76zqqSjC5RpRS6Z/z0BqKCXUp/mn+1
         CooZr2XGxTTuJ6xPJOZM05TcU68J19t9lR5FxlW4=
Date:   Tue, 1 Oct 2019 17:49:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chris Hoy Poy via RT <kernel-helpdesk@rt.linuxfoundation.org>
Cc:     djwong@kernel.org, fstests@vger.kernel.org
Subject: Re: [Kernel.org Helpdesk #79165] please add fstests@vger.kernel.org
 to lore.kernel.org
Message-ID: <20191002004918.GB13097@magnolia>
References: <RT-Ticket-79165@linuxfoundation>
 <20190903231702.GA5339@magnolia>
 <rt-4.4.0-1780-1569466036-1450.79165-6-0@linuxfoundation>
 <20190930194315.GA13097@magnolia>
 <rt-4.4.0-5374-1569872597-133.79165-6-0@linuxfoundation>
 <rt-4.4.0-12635-1569918200-1370.79165-6-0@linuxfoundation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rt-4.4.0-12635-1569918200-1370.79165-6-0@linuxfoundation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 01, 2019 at 04:23:20AM -0400, Chris Hoy Poy via RT wrote:
> Hi Darrick,
> 
> I've set this up now - 
> 
> https://lore.kernel.org/fstests

Thank you!

--D

> cheers
> /Chris
> 
> On Tue Oct 01 03:43:17 2019, djwong@kernel.org wrote:
> > Hi Chris,
> > 
> > On Wed, Sep 25, 2019 at 10:47:16PM -0400, Chris Hoy Poy via RT wrote:
> > > Hi,
> > >
> > > Please feel free to throw some archives my way
> > >  (choypoy@linuxfoundation.org) and I'll import them and set this up
> > > :)
> > 
> > Ok, here's what I've been able to package so far:
> > 
> > https://djwong.org/docs/fstests.tar.xz
> > 
> > With sha256sum of:
> > 
> > 905192de19298a4a21dafdd3a715183320f12ea02c0b16a96aa0c792eb810262
> > fstests.tar.xz
> > 
> > I think the list history goes further back than May 2014, but that's
> > all
> > I've been able to collect.
> > 
> > --D
> > 
> > > cheers
> > > /Chris
> > >
> > > On Wed Sep 04 07:17:07 2019, djwong@kernel.org wrote:
> > > > Hi, could you please start archiving the fstests@vger.kernel.org
> > > > mailing
> > > > list on lore.kernel.org?
> > > >
> > > > (And now that I have actual experience running list-archive-
> > > > maker.py I
> > > > can supply archives fairly quickly unlike linux-xfs...)
> > > >
> > > > Thank you!
> > > >
> > > > --Darrick
> > >
> > >
> > > --
> > > Chris Hoy Poy
> > > Collaborative Projects IT
> > > The Linux Foundation
> 
> 
> -- 
> Chris Hoy Poy
> Collaborative Projects IT
> The Linux Foundation
