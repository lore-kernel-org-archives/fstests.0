Received: from mx1.redhat.com ([209.132.183.28]:52970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdF3M0n (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Jun 2017 08:26:43 -0400
Date: Fri, 30 Jun 2017 20:26:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: Some tests not run: not suitable for this OS: Linux
Message-ID: <20170630122641.GF23360@eguan.usersys.redhat.com>
References: <20170630121212.GS2866@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170630121212.GS2866@twin.jikos.cz>
Sender: fstests-owner@vger.kernel.org
To: David Sterba <dsterba@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 30, 2017 at 02:12:12PM +0200, David Sterba wrote:
> Hi,
> 
> I've noticed in the log:
> 
> generic/093 -- not suitable for this OS: Linux
> generic/097 -- not suitable for this OS: Linux
> generic/099 -- not suitable for this OS: Linux
> 
> all with "_supported_os IRIX", so I wonder if the tests should be
> removed or at least reviewed if they make sense to enable for linux.
> They test xattrs, acl or capabilities.

Yes, there's a plan to remove IRIX support and associated tests & files
& code. Eric Biggers is kind enough that he has sent out such a
patchset[1] to do so. And Darrick asked to make the xattr and acl
tests compatible with Linux instead of simply removing them. v2 is not
out yet, but it's not a high priority task, I think we can wait :)

Thanks,
Eryu

[1] https://www.spinics.net/lists/fstests/msg06385.html
