Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56901 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728071AbfFGNdI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jun 2019 09:33:08 -0400
Date: Fri, 7 Jun 2019 09:32:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 2/2] ext4/036: Add tests for filename casefolding
 feature
Message-ID: <20190607133255.GB19820@mit.edu>
References: <20190606193138.25852-1-krisman@collabora.com>
 <20190606193138.25852-2-krisman@collabora.com>
 <20190607052331.GA19838@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607052331.GA19838@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 06, 2019 at 10:23:31PM -0700, Christoph Hellwig wrote:
> On Thu, Jun 06, 2019 at 03:31:38PM -0400, Gabriel Krisman Bertazi wrote:
> > 
> > For now, let it live in ext4 and we move to shared/ or generic/ when
> > other filesystems supporting this feature start to pop up.
> 
> Please keep it in shared/ from the start.  There isn't really anything
> ext4 specific.  In fact xfs already supports CI file systems, just
> without utf8 tables for now.

Agreed; the only things which are fs specific are things which you've
already done a great job abstracting away in common/casefold.

      	  	      	       	       - Ted
