Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98101C34047
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B27C24656
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 15:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBSPVO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:21:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55067 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726634AbgBSPVO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 10:21:14 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01JFKKQq000942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 10:20:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 730374211EF; Wed, 19 Feb 2020 10:20:20 -0500 (EST)
Date:   Wed, 19 Feb 2020 10:20:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200219152020.GH330201@mit.edu>
References: <20200213211011.GB6600@quack2.suse.cz>
 <062ac52c-3a16-22ef-6396-53334ed94783@cn.fujitsu.com>
 <20200214150059.GA22815@quack2.suse.cz>
 <a0b06474-f447-7943-1012-2a8d20b9e352@cn.fujitsu.com>
 <20200218082436.GF16121@quack2.suse.cz>
 <83cc6208-3fa3-86bb-eb91-77b90b22d98f@cn.fujitsu.com>
 <20200218110311.GI16121@quack2.suse.cz>
 <b0b82e0c-0e86-af5e-5a61-2fafb2ca85a0@cn.fujitsu.com>
 <73af3d5c-ca64-3ad3-aee2-1e78ee4fae4a@cn.fujitsu.com>
 <20200219124324.GO16121@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219124324.GO16121@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 19, 2020 at 01:43:24PM +0100, Jan Kara wrote:
> This means, fsstress command has queued cache flush request (from
> blkdev_issue_flush()), this has been dispatched to the driver ('D' event)
> but it has never been completed by the driver and so blkdev_issue_flush()
> never returns.
> 
> To debug this further, you probably need to start looking into what happens
> with the request inside QEMU. There's not much I can help you with at this
> point since I'm not an expert there. Do you use image file as a backing store
> or a raw partition?

This is looking more and more like a Qemu bug or a host OS issue.
Yang is using a two year old Qemu (qemu-kvm-2.12.0-32.el8+1900+70997154)
and is using a QCOW backing file.  It also could be a host kernel bug,
although that's less likely.

Yang, any chance you could have a chance to upgrade to a newer version
of Qemu, and see if the problem goes away?  If you have a RHEL support
contract, perhaps you could file a support request with the Red Hat help desk?

	  	      	    	   	   	   - Ted
