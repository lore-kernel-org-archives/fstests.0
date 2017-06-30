Received: from mx2.suse.de ([195.135.220.15]:54476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752056AbdF3MNX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Jun 2017 08:13:23 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E5C0AD59
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2017 12:13:22 +0000 (UTC)
Date: Fri, 30 Jun 2017 14:12:12 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Some tests not run: not suitable for this OS: Linux
Message-ID: <20170630121212.GS2866@twin.jikos.cz>
Reply-To: dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

I've noticed in the log:

generic/093 -- not suitable for this OS: Linux
generic/097 -- not suitable for this OS: Linux
generic/099 -- not suitable for this OS: Linux

all with "_supported_os IRIX", so I wonder if the tests should be
removed or at least reviewed if they make sense to enable for linux.
They test xattrs, acl or capabilities.

d.
