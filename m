Received: from mail-pf1-f194.google.com ([209.85.210.194]:39988 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTL3P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Jun 2019 07:29:15 -0400
Date: Thu, 20 Jun 2019 19:29:03 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190620112903.GF15846@desktop>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616200154.GA7251@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 16, 2019 at 04:01:54PM -0400, Theodore Ts'o wrote:
> On Sun, Jun 16, 2019 at 10:44:40PM +0800, Eryu Guan wrote:
> > On Wed, Jun 12, 2019 at 02:40:33PM -0400, Gabriel Krisman Bertazi wrote:
> > Test looks good to me, and test passes for me with v5.2-rc4 kernel and
> > latest e2fsprogs, thanks! Just that, I moved the test to generic, as we
> > have all the needed _require rules ready to _notrun on unsupported fs,
> > so it's ready to be generic. (Sorry I was not involved with the
> > ext4-shared-generic discussion in the first place)
> 
> Just to clear up my confusion, what's the distinction between shared
> and generic?  Is it that if there are explicit "only run this test on
> file systems xxx, yyy, and zzz declarations", then it should be
> shared, and otherwise it should be in generic?
> 
> 						- Ted

IMO, shared tests are generic tests that don't have proper _require
rules, so they're hard-coded with explicit "_supported_fs xxx yyy". With
proper _require rules, there should be no shared tests at all, and we'd
try avoid adding new shared tests if possible.

Thanks,
Eryu
