Received: from bombadil.infradead.org ([65.50.211.133]:45123 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdHaNJe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2017 09:09:34 -0400
Date: Thu, 31 Aug 2017 06:09:33 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [fstests PATCH] generic: add test for executables on read-only
 DAX mounts
Message-ID: <20170831130933.GB19544@infradead.org>
References: <20170829213721.GA27686@linux.intel.com>
 <20170829223715.26507-1-ross.zwisler@linux.intel.com>
 <20170830145103.GA10163@infradead.org>
 <20170831040255.GB17095@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831040255.GB17095@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>, linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, Randy Dodgen <rdodgen@gmail.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 30, 2017 at 10:02:55PM -0600, Ross Zwisler wrote:
> > > +LS=$(which ls --skip-alias --skip-functions) 2>/dev/null
> > > +if [ $? -ne 0 ]; then
> > > +	status=$?
> > > +	echo "Couldn't find 'ls'!?"
> > > +	exit
> > > +fi
> > 
> > These checks all fail for me..
> 
> Huh...really?  I'll send out v2 in a second, but if that fails for you as well
> can you try and give me a hint as to what's going wrong with the test in your
> setup?

The v2 one works fine for me.
