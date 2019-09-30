Return-Path: <SRS0=U1nr=XZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D261C32792
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Sep 2019 21:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE246224FE
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Sep 2019 21:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfI3VBT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:01:19 -0400
Received: from smtp1.linuxfoundation.org ([140.211.169.13]:56424 "EHLO
        smtp1.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VBT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Sep 2019 17:01:19 -0400
Received: from rt.cvo.linuxfoundation.org (rt.cvo.linuxfoundation.org [172.17.192.131])
        by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 72F018AD
        for <fstests@vger.kernel.org>; Mon, 30 Sep 2019 19:43:17 +0000 (UTC)
Received: by rt.cvo.linuxfoundation.org (Postfix, from userid 48)
        id 6CCB26FE; Mon, 30 Sep 2019 19:43:17 +0000 (UTC)
Subject: Re: [Kernel.org Helpdesk #79165] please add fstests@vger.kernel.org to lore.kernel.org
From:   "Darrick J. Wong via RT" <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20190930194315.GA13097@magnolia>
References: <RT-Ticket-79165@linuxfoundation>
 <20190903231702.GA5339@magnolia>
 <rt-4.4.0-1780-1569466036-1450.79165-6-0@linuxfoundation>
 <20190930194315.GA13097@magnolia>
Message-ID: <rt-4.4.0-5374-1569872597-1891.79165-6-0@linuxfoundation>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #79165
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: djwong@kernel.org
CC:     fstests@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Mon, 30 Sep 2019 15:43:17 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

