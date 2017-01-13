Received: from mx2.suse.de ([195.135.220.15]:45657 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751365AbdAMKLt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 13 Jan 2017 05:11:49 -0500
Date: Fri, 13 Jan 2017 11:11:09 +0100
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 3/3] common: remove tmp.mkfs[err/std] files by name
Message-ID: <20170113111109.66f6837d@suse.de>
In-Reply-To: <20170113042404.GY1859@eguan.usersys.redhat.com>
References: <20170112132656.7caa64dd@suse.de>
        <20170112171849.10784-1-ddiss@suse.de>
        <20170112171849.10784-3-ddiss@suse.de>
        <20170113042404.GY1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, 13 Jan 2017 12:24:04 +0800, Eryu Guan wrote:

> On Thu, Jan 12, 2017 at 06:18:49PM +0100, David Disseldorp wrote:
> > Without any $tmp suffix, users silly enough to run xfstests without
> > mktemp present will unintentionally "rm -f *".  
> 
> mktemp creates a file too, removing $tmp.xxx files won't remove $tmp
> file itself. So along with removing them by name, I'm thinking about
> initializing tmp with /tmp/$$._mkfs (or something like that) as well.

Oh, yes I missed the extra $tmp rm parameter.

> I have another tmp file cleanup patch[1] pending in the list, would you
> like to do all the cleanup fix in your patch? Or I can fold your patch
> to mine and send out v3.

Please fold it into your patchset.

Cheers, David
