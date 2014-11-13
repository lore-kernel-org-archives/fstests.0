Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5832 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586AbaKMD21 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 22:28:27 -0500
Date: Thu, 13 Nov 2014 14:28:24 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: enable tests that require scratch device on CIFS
Message-ID: <20141113032824.GB28565@dastard>
References: <1415617191-17246-1-git-send-email-eguan@redhat.com>
 <CAH2r5muXH7HSoM0TQUsPXq1RM-dLdZSfzuOKK1zZdKe0OANAhg@mail.gmail.com>
 <20141110160309.GI2863@dhcp-13-216.nay.redhat.com>
 <CAH2r5mtCPVt7+fyCjvDrLtOSzX1-+YQ_ZPhyU5gjFP7c1DJFKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtCPVt7+fyCjvDrLtOSzX1-+YQ_ZPhyU5gjFP7c1DJFKw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

[ please don't top post. ]

On Wed, Nov 12, 2014 at 05:26:13PM -0600, Steve French wrote:
> I get newly enabled test 294 passing on cifs mounts to Samba.
> 
> What is best way to get the mount options passed to the mount of
> scratch dev so it doesn't prompt for it?

# MOUNT_OPTIONS="-o ...." ./check -g auto

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
