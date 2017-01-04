Received: from sandeen.net ([63.231.237.45]:45516 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbdADXFa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 18:05:30 -0500
Subject: Re: trouble with generic/081
References: <20161214164314.GA25105@infradead.org>
 <20161215063650.GJ4326@dastard> <20161215084224.GA14395@infradead.org>
 <c05b64b6-80d3-655d-db9b-6f49038e53ee@redhat.com>
 <20161216081523.GA13847@infradead.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5806882c-4807-cb2a-80dd-147de5bf176a@sandeen.net>
Date: Wed, 4 Jan 2017 17:03:46 -0600
MIME-Version: 1.0
In-Reply-To: <20161216081523.GA13847@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Zdenek Kabelac <zkabelac@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, eguan@redhat.com, fstests@vger.kernel.org, dm-devel@redhat.com
List-ID: <fstests@vger.kernel.org>



On 12/16/16 2:15 AM, Christoph Hellwig wrote:
> On Thu, Dec 15, 2016 at 10:16:23AM +0100, Zdenek Kabelac wrote:
>> So let me explain the logic behind this 'amazingly stupid' idea.
> 
> And that logic doesn't make any sense at all.  invibly unmounting
> a file system behind the users back is actively harmful, as it is
> contradicting the principle of least surprise, and the xfstests mess
> is one simple example for it.  Add a callback in-kernel to tell the
> fs to shut down but NOT unmount and expose the namespace below it,
> which the administrator has probably intentionally hid.
> 
> Even worse unmount may trigger further writes and with fses not
> handling them the fs might now be stuck after being detached from
> the namespace without a way for the admin to detect or recover this.
> 
> What XFS did on IRIX was to let the volume manager call into the fs
> and shut it down.  At this point no further writes are possible,
> but we do not expose the namespace under the mount point, and the
> admin can fix the situation with all the normal tools.

<late to the party>

Is there a need for this kind of call-up when xfs now has the configurable
error handling so that it will shut down after X retries or Y seconds 
of a persistent error?

-Eric
