Received: from mail-pf1-f196.google.com ([209.85.210.196]:33100 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfCFMwk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Mar 2019 07:52:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so8553713pfd.0
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2019 04:52:40 -0800 (PST)
Date: Wed, 6 Mar 2019 20:52:34 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] Add new xattr test 532
Message-ID: <20190306125234.GJ2824@desktop>
References: <20190305043613.11752-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305043613.11752-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 05, 2019 at 02:36:13PM +1000, Ronnie Sahlberg wrote:
> This test is cloned from 097 but has had all the tests for trusted.*
> removed.
> This makes it possible to use this test on filesystems that can only
> provide user.* xattrs such as CIFS.
> 
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>

Sorry I missed your last patch of this clone..

Do I need to do special setup for CIFS to support xattr? Currently I got
test _notrun because attrs are not supported by CIFS. I was mounting a
local samba server with

-o vers=3.0 -o username=user,password=passwd,sfu -o context=system_u:object_r:root_t:s0 //localhost/scratch /mnt/scratch

Kernel is 5.0.0-rc7.

But instead of cloning all the user.* xattr tests, I think it's better
to split generic/097, leave all trusted.* xattr tests there and move all
user.* xattr tests to this new test. So we don't have to maintain two
copys of the same user.* xattr tests.

Thanks,
Eryu
