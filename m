Return-Path: <SRS0=U1nr=XZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23834C32792
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Sep 2019 21:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D6622509
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Sep 2019 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569877254;
	bh=m109fHkGrJk8QpHK8ApHjNfwnB7x/ujAvp+zlrIQ2ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQflC0w9J6kz8QOCYfH49v/oERnPLCQkCXKOjr0X1z5CIUIgT2r+OM7TMMw36WGNj
	 6DRDWDD4uaYLFLvU/K+71xAUVyuY5H/7PupPWei8AAzMkTMrwezS1fDj8ANPSuBCMj
	 IbUhL2sBmRQQ0vdWt4GHMBxoe1PffLJ5+88vgU28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfI3VAx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3VAx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Sep 2019 17:00:53 -0400
Received: from localhost (c-67-161-8-12.hsd1.ca.comcast.net [67.161.8.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F64224EF;
        Mon, 30 Sep 2019 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569872596;
        bh=m109fHkGrJk8QpHK8ApHjNfwnB7x/ujAvp+zlrIQ2ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIsz9ZhouX37qshMP+opptxUpHPVGeQJx5nKTKMPt8cQvkEtwDLautGp+K5UCoTmN
         WNLcgMWhGe4LLROpzgXDfKLqMCZYI4ywAdi+/ENDg0B/FdA06mJlxwEbd6fk8fSQ+R
         iKIG882BqWa2n9ZGaHNqL9GYAWQeGuNJIljGF1Zc=
Date:   Mon, 30 Sep 2019 12:43:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     choypoy@linuxfoundation.org
Cc:     Chris Hoy Poy via RT <kernel-helpdesk@rt.linuxfoundation.org>,
        djwong@kernel.org, fstests@vger.kernel.org
Subject: Re: [Kernel.org Helpdesk #79165] please add fstests@vger.kernel.org
 to lore.kernel.org
Message-ID: <20190930194315.GA13097@magnolia>
References: <RT-Ticket-79165@linuxfoundation>
 <20190903231702.GA5339@magnolia>
 <rt-4.4.0-1780-1569466036-1450.79165-6-0@linuxfoundation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rt-4.4.0-1780-1569466036-1450.79165-6-0@linuxfoundation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Chris,

On Wed, Sep 25, 2019 at 10:47:16PM -0400, Chris Hoy Poy via RT wrote:
> Hi,
> 
> Please feel free to throw some archives my way
> (choypoy@linuxfoundation.org) and I'll import them and set this up :) 

Ok, here's what I've been able to package so far:

https://djwong.org/docs/fstests.tar.xz

With sha256sum of:

905192de19298a4a21dafdd3a715183320f12ea02c0b16a96aa0c792eb810262  fstests.tar.xz

I think the list history goes further back than May 2014, but that's all
I've been able to collect.

--D

> cheers
> /Chris
> 
> On Wed Sep 04 07:17:07 2019, djwong@kernel.org wrote:
> > Hi, could you please start archiving the fstests@vger.kernel.org mailing
> > list on lore.kernel.org?
> > 
> > (And now that I have actual experience running list-archive-maker.py I
> > can supply archives fairly quickly unlike linux-xfs...)
> > 
> > Thank you!
> > 
> > --Darrick
> 
> 
> -- 
> Chris Hoy Poy
> Collaborative Projects IT
> The Linux Foundation
