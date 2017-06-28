Received: from mx2.suse.de ([195.135.220.15]:33346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752355AbdF1OWC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Jun 2017 10:22:02 -0400
Date: Wed, 28 Jun 2017 16:21:59 +0200
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 1/2] generic/430: Fix filename in "copy beyond end" test
Message-ID: <20170628162159.19813961@suse.de>
In-Reply-To: <20170626164053.7634-1-lhenriques@suse.com>
References: <20170626164053.7634-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, 26 Jun 2017 17:40:52 +0100, Luis Henriques wrote:

> The cmp command was using the wrong file to perform the comparison.  Use
> $testdir/beyond instead of $testdir/end.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

This looks correct to me.
Reviewed-by: David Disseldorp <ddiss@suse.de>
