Received: from mx1.redhat.com ([209.132.183.28]:50293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602AbbJVGmB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Oct 2015 02:42:01 -0400
Date: Thu, 22 Oct 2015 14:41:58 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: move ext4/30[1234] from the dangerous to the
 auto group
Message-ID: <20151022064158.GJ3558@dhcp-13-216.nay.redhat.com>
References: <1445226219-8496-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445226219-8496-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 18, 2015 at 11:43:39PM -0400, Theodore Ts'o wrote:
> The ext4/301, ext4/302, ext4/303, and ext4/304 tests are not crashing
> on 3.10.89, 3.14.53, 3.18.21, 4.1.8, and 4.3-rc2.  So promote these
> tests from the dangerous to the auto group.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I've been running ext4/30[1-4] on RHEL kernels for a year and I see no
crashing either.

Reviewed-by: Eryu Guan <eguan@redhat.com>
