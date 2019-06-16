Received: from mail-pf1-f194.google.com ([209.85.210.194]:40157 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfFPOop (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Jun 2019 10:44:45 -0400
Date: Sun, 16 Jun 2019 22:44:40 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3 2/2] shared/012: Add tests for filename casefolding
 feature
Message-ID: <20190616144440.GD15846@desktop>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612184033.21845-2-krisman@collabora.com>
Sender: fstests-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 12, 2019 at 02:40:33PM -0400, Gabriel Krisman Bertazi wrote:
> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
> 
> This new test implements verification for the per-directory
> case-insensitive feature, as supported by the reference implementation
> in Ext4.
> 
> Signed-off-by: Lakshmipathi.G <lakshmipathi.ganapathi@collabora.co.uk>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>   [Rewrite to support feature design]
>   [Refactor to simplify implementation]

Test looks good to me, and test passes for me with v5.2-rc4 kernel and
latest e2fsprogs, thanks! Just that, I moved the test to generic, as we
have all the needed _require rules ready to _notrun on unsupported fs,
so it's ready to be generic. (Sorry I was not involved with the
ext4-shared-generic discussion in the first place)

Thanks,
Eryu
