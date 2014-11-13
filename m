Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:54919 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975AbaKMF0U (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 13 Nov 2014 00:26:20 -0500
Date: Thu, 13 Nov 2014 16:26:17 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstest status on current kernels
Message-ID: <20141113052617.GH28565@dastard>
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
 <20141113032626.GA28565@dastard>
 <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
 <20141113042231.GD28565@dastard>
 <CAH2r5mu47ev3=+z7D9tC-jwBpmys=uYe_eooiCa3CtXBNzMXXg@mail.gmail.com>
 <20141113044405.GF28565@dastard>
 <CAH2r5mtibBSeNmcbmOsfvaTny7_7AS7Rhh9z8qagGU6T4wjE8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtibBSeNmcbmOsfvaTny7_7AS7Rhh9z8qagGU6T4wjE8w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 11:09:44PM -0600, Steve French wrote:
> This (generic/test3) will likely be one that we want to continue
> to skip on a network fs.

Then you want to add send a patch that adds CIFS to very recent
check added for NFS:

f72abf5 generic: skip atime related tests on NFS

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
