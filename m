Return-Path: <SRS0=5J60=4B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D66C2BA83
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 17:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58CB206DB
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Feb 2020 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBMRPf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:15:35 -0500
Received: from outgoing-auth-2.mit.edu ([18.7.34.11]:39819 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727781AbgBMRPf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Feb 2020 12:15:35 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 12:15:35 EST
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01DH8tE0027957
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 12:08:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 96A7542032C; Thu, 13 Feb 2020 12:08:53 -0500 (EST)
Date:   Thu, 13 Feb 2020 12:08:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Jan Kara <jack@suse.cz>, fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200213170853.GA311476@mit.edu>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 13, 2020 at 04:49:21PM +0800, Yang Xu wrote:
> 
> 
> on 2020/02/12 18:54, Jan Kara wrote:
> > Hello!
> > 
> > On Tue 11-02-20 16:14:35, Yang Xu wrote:
> > > Since xfstests support rename2, this case(generic/269) reports filesystem
> > > inconsistent problem with ext4 on my system(4.18.0-32.el8.x86_64).
> > 
> > I don't remember seeing this in my testing... It might be specific to that
> > RHEL kernel.
>
> Agree.

So were you able to reproduce this on a 5.6.0-rc1 kernel or not?

If you are, can you send the .config that you used, in case it's
configuration specific?

					- Ted
