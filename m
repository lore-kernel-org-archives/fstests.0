Received: from mail-yw0-f172.google.com ([209.85.161.172]:45107 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423473AbdKRUfB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Nov 2017 15:35:01 -0500
MIME-Version: 1.0
In-Reply-To: <20171118055804.17611-2-chandan@linux.vnet.ibm.com>
References: <20171118055804.17611-1-chandan@linux.vnet.ibm.com> <20171118055804.17611-2-chandan@linux.vnet.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 18 Nov 2017 22:35:00 +0200
Message-ID: <CAOQ4uxjfaGMbVtHy+fSOLV8=S56ZOfExC1AQ1Zo9Qm4UrjWVoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] overlay/018: Add constant d_ino test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Nov 18, 2017 at 7:58 AM, Chandan Rajendra
<chandan@linux.vnet.ibm.com> wrote:
> Constant d_ino for hardlinks is possible only when "index" config
> feature/mount option is enabled.
>
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Looks good and tested.

Thanks,
Amir.
