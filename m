Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8898FC2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646A524649
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgBNOF6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:05:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54134 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgBNOF6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 09:05:58 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01EE5flD009019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 09:05:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 82D5D42032C; Fri, 14 Feb 2020 09:05:41 -0500 (EST)
Date:   Fri, 14 Feb 2020 09:05:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Jan Kara <jack@suse.cz>, fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200214140541.GA434121@mit.edu>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
 <20200213170853.GA311476@mit.edu>
 <1c81c16b-6e31-74cb-0b88-46663fad500d@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c81c16b-6e31-74cb-0b88-46663fad500d@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 14, 2020 at 09:14:33AM +0800, Yang Xu wrote:
> > 
> > So were you able to reproduce this on a 5.6.0-rc1 kernel or not?
> No. I don't reproduce it on 5.6.0-rc1 kernel, but  5.6.0-rc1 kernel hang on
> my KVM machine when run generic/269.

I'm not able to reproduce the 5.6.0-rc1 hang using kvm-xfstests[1].
Neither has any other ext4 developers, which is why it might be useful
to see if there's something unique in your .config for 5.6.0-rc1.
Could you send us the .config you were using?

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md

Cheers,

						- Ted
						
