Received: from mx1.redhat.com ([209.132.183.28]:35734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750874AbdAMEfD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jan 2017 23:35:03 -0500
Date: Fri, 13 Jan 2017 12:24:04 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 3/3] common: remove tmp.mkfs[err/std] files by name
Message-ID: <20170113042404.GY1859@eguan.usersys.redhat.com>
References: <20170112132656.7caa64dd@suse.de>
 <20170112171849.10784-1-ddiss@suse.de>
 <20170112171849.10784-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112171849.10784-3-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 12, 2017 at 06:18:49PM +0100, David Disseldorp wrote:
> Without any $tmp suffix, users silly enough to run xfstests without
> mktemp present will unintentionally "rm -f *".

mktemp creates a file too, removing $tmp.xxx files won't remove $tmp
file itself. So along with removing them by name, I'm thinking about
initializing tmp with /tmp/$$._mkfs (or something like that) as well.

I have another tmp file cleanup patch[1] pending in the list, would you
like to do all the cleanup fix in your patch? Or I can fold your patch
to mine and send out v3.

Thanks,
Eryu

[1] http://www.spinics.net/lists/fstests/msg04953.html
