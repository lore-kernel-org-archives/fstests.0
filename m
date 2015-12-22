Received: from plane.gmane.org ([80.91.229.3]:34162 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbbLVDAF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 21 Dec 2015 22:00:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcff-fstests@m.gmane.org>)
	id 1aBDBE-00035L-6z
	for fstests@vger.kernel.org; Tue, 22 Dec 2015 04:00:04 +0100
Received: from ip5f5ae08a.dynamic.kabel-deutschland.de ([95.90.224.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 04:00:04 +0100
Received: from hurikhan77 by ip5f5ae08a.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 04:00:04 +0100
From: Kai Krakow <hurikhan77@gmail.com>
Subject: Re: Ideas to do custom operation just after mount?
Date: Tue, 22 Dec 2015 01:14:24 +0100
Message-ID: <20151222011424.03247982@jupiter.sol.kaishome.de>
References: <56721602.5050204@cn.fujitsu.com>
	<20151221001654.GM19802@dastard>
	<56776330.1090500@cn.fujitsu.com>
	<5677662F.2060806@cn.fujitsu.com>
	<56778B9E.8050900@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Am Mon, 21 Dec 2015 13:18:22 +0800
schrieb Anand Jain <anand.jain@oracle.com>:

> 
> 
> > BTW, any good idea for btrfs to do such operation like
> > enabling/disabling some minor features? Especially when it can be
> > set on individual file/dirs.
> >
> > Features like incoming write time deduplication, is designed to be
> > enabled/disabled for individual file/dirs, so it's not a quite good
> > idea to use mount option to do it.
> >
> > Although some feature, like btrfs quota(qgroup), should be
> > implemented by mount option though.
> > I don't understand why qgroup is enabled/disabled by ioctl. :(
> 
> 
> mount option won't persist across systems/computers unless remembered
> by human.

Valid point, tho here's an counter-example: space-cache is persisted.
Once enabled, it's always there until you clear AND disable it during
initial mount.

-- 
Regards,
Kai

Replies to list-only preferred.

