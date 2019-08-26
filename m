Received: from bhuna.collabora.co.uk ([46.235.227.227]:52230 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbfHZUGH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Aug 2019 16:06:07 -0400
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] common/casefold: only check for the Casefold flag
References: <20190826175020.28959-1-tytso@mit.edu>
Date: Mon, 26 Aug 2019 16:06:01 -0400
In-Reply-To: <20190826175020.28959-1-tytso@mit.edu> (Theodore Ts'o's message
        of "Mon, 26 Aug 2019 13:50:20 -0400")
Message-ID: <85pnkrzo7q.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

"Theodore Ts'o" <tytso@mit.edu> writes:

> The _casefold_lsattr_dir function lists all of the file attributes.
> As result, tests/generic/556.out has an ext4-specific assumption that
> files will have the Extents attribute.  That won't be true for all
> file systems, and it won't even be true for ext4 file systems that do
> not have the extents feature enabled.
>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
