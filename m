Received: from mail-yw0-f182.google.com ([209.85.161.182]:35805 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965034AbeEIQWt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 May 2018 12:22:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180509152705.GA10101@redhat.com>
References: <20180509152705.GA10101@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 May 2018 19:22:48 +0300
Message-ID: <CAOQ4uxgRb0T6nWou7uasOF+QGEHRMa1C5wD4AsJABJDXK+yNhQ@mail.gmail.com>
Subject: Re: [PATCH V2] xfstest: overlay: Add tests for overlay metadata only
 copy up feature
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 9, 2018 at 6:27 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> Hi,
>
> Please find attached the V2 of the patch. Took care of Amir's comments
> from previous version.
>
> Add tests for metadata only copy up feature.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Just a note to Eryu -

You may want to hold on to this test until metacopy is merged
or at least staged on Miklos' next branch.

Up to you.

Thanks,
Amir.
