Received: from mx2.suse.de ([195.135.220.15]:34738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933959AbdDFQOF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Apr 2017 12:14:05 -0400
Date: Thu, 6 Apr 2017 18:13:58 +0200
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] fstests: Remove IRIX os support from template
Message-ID: <20170406181358.741ac82d@suse.de>
In-Reply-To: <20170406153453.2e5fhjqiamllpce4@thunk.org>
References: <20170405032628.22370-1-quwenruo@cn.fujitsu.com>
        <20170406140233.20dc6553@suse.de>
        <20170406153453.2e5fhjqiamllpce4@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, 6 Apr 2017 11:34:53 -0400, Theodore Ts'o wrote:

> > Looking forward to seeing the floodgates open for the rest of the Irix
> > removal changes.  
> 
> Wouldn't it be better to do a wholesale removal of Irix support
> instead of having lots of teeny-tiny patches?

Yes, sounds reasonable to me. Ensuring that any new tests are created
without explicit Irix support would still be a worthwhile start IMO.

Cheers, David
