Received: from imap.thunk.org ([74.207.234.97]:42468 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeEEWXv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 5 May 2018 18:23:51 -0400
Date: Sat, 5 May 2018 18:23:47 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] README: document the new default run mode
Message-ID: <20180505222347.GO29205@thunk.org>
References: <20180505001951.5665-1-david@fromorbit.com>
 <CAOQ4uxgJ4+R05wfkgCA6DUEoQbPPJEhTGiE=5QDqoX5hjE7D7A@mail.gmail.com>
 <20180505140911.GE8373@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505140911.GE8373@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, May 05, 2018 at 10:09:11PM +0800, Eryu Guan wrote:
> t
> The 'dangerous' group and 'auto' group are not mutually exclusive when
> it was introduced, see commit 3f28d55c3954 ("add freeze and dangerouss
> groups"). But from previous discussions[1][2], they should be mutually
> exclusive.

What might be nice is if there was some way to declare that a test is
dangerous given a particular kernel version (or some combination of
kernel version and file system type).  Right now I have to manually
exclude tests when testing stable kernels, e.g.:

gce-xfstests full --kernel gs://gce-xfstests/bzImage-3.18 -X generic/269 -X ext4/022

It's not a huge deal, and it's been on my todo list to add into the
{gce,kvm,android}-xfstests framework, but perhaps it belongs in the
core xfstests framework.

						- Ted
