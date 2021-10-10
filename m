Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C8C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 23:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023F960EE7
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Oct 2021 23:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhJJX1V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Oct 2021 19:27:21 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:52889 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232812AbhJJX1V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Oct 2021 19:27:21 -0400
X-Greylist: delayed 1100 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Oct 2021 19:27:21 EDT
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id EB53C862767
        for <fstests@vger.kernel.org>; Mon, 11 Oct 2021 10:07:01 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mZhuH-004nTH-01
        for fstests@vger.kernel.org; Mon, 11 Oct 2021 10:07:01 +1100
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1mZhuG-000uFK-Ub
        for fstests@vger.kernel.org;
        Mon, 11 Oct 2021 10:07:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: fstests: fix build issues
Date:   Mon, 11 Oct 2021 10:06:57 +1100
Message-Id: <20211010230659.216166-1-david@fromorbit.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61637216
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=8gfv0ekSlNoA:10 a=N9HaImM3EXCIgHpMm3IA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

With Debian unstable moving all it's userspace forwards after the
recent release, fstests inew issues a bunch of warnings when running
autoconf. Update the autoconf scripts so that they don't make a
bunch of noise anymore.

Also, when building with different users, the group file build can
fail to overwrite the group files, resulting in build failures. Fix
that, too.

Cheers,

Dave.

