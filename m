Received: from mail-pg1-f195.google.com ([209.85.215.195]:42623 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfDZDLk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 23:11:40 -0400
Date: Fri, 26 Apr 2019 11:11:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] btrfs: fix filtering of scratch device in test case
 048
Message-ID: <20190426031133.GC15846@desktop>
References: <20190425002457.28648-1-fdmanana@kernel.org>
 <20190425003709.28749-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425003709.28749-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 25, 2019 at 01:37:09AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The recent commit 4529b20e1aa8f9 ("btrfs/048: amend property validation
> cases"), does not properly filter the scratch device because the error
> messages are sent to stderr and not to stdout, and the pipe filter only
> gets input from the stdout of the btrfs utility. We need to redirect the
> stderr of the btrfs utility to its stdout.
> 
> Further, the golden output had the path "/mnt/scratch" hardcoded, instead
> of using SCRATCH_MNT. Fix that as well.
> 
> The test was failing on any setup where the scratch device is not mounted
> at "/mnt/scratch".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for fixing it! Sorry that I missed the issues in review..

Eryu
