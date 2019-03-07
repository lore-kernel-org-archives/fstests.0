Received: from mx1.redhat.com ([209.132.183.28]:51502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfCGCqX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Mar 2019 21:46:23 -0500
Date: Wed, 6 Mar 2019 21:46:23 -0500 (EST)
From: Ronnie Sahlberg <lsahlber@redhat.com>
Message-ID: <22121819.6359026.1551926783232.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190306125234.GJ2824@desktop>
References: <20190305043613.11752-1-lsahlber@redhat.com> <20190306125234.GJ2824@desktop>
Subject: Re: [PATCH] Add new xattr test 532
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>





----- Original Message -----
> From: "Eryu Guan" <guaneryu@gmail.com>
> To: "Ronnie Sahlberg" <lsahlber@redhat.com>
> Cc: "fstests" <fstests@vger.kernel.org>
> Sent: Wednesday, 6 March, 2019 10:52:34 PM
> Subject: Re: [PATCH] Add new xattr test 532
> 
> On Tue, Mar 05, 2019 at 02:36:13PM +1000, Ronnie Sahlberg wrote:
> > This test is cloned from 097 but has had all the tests for trusted.*
> > removed.
> > This makes it possible to use this test on filesystems that can only
> > provide user.* xattrs such as CIFS.
> > 
> > Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> 
> Sorry I missed your last patch of this clone..

No worries.  I will resend it later once I address Daves concerns.

> 
> Do I need to do special setup for CIFS to support xattr? Currently I got
> test _notrun because attrs are not supported by CIFS. I was mounting a
> local samba server with
> 
> -o vers=3.0 -o username=user,password=passwd,sfu -o
> context=system_u:object_r:root_t:s0 //localhost/scratch /mnt/scratch

You don't need the 'sfu' mount option but you likely need to make sure you have the proper vfs modules loaded for samba:
I use this on my share :

[Share]
	path = /Share
	read only = no
	guest ok = no
	vfs objects = acl_xattr, streams_xattr aio_pthread
	ea support = yes
	aio read size = 16384
	aio write size = 16384

I think the only important one is ea support = yes (the xattrs are stored as EAs)



> 
> Kernel is 5.0.0-rc7.
> 
> But instead of cloning all the user.* xattr tests, I think it's better
> to split generic/097, leave all trusted.* xattr tests there and move all
> user.* xattr tests to this new test. So we don't have to maintain two
> copys of the same user.* xattr tests.
> 
> Thanks,
> Eryu
> 
